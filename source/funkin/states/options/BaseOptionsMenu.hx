package funkin.states.options;

import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.FlxGamepadManager;

import funkin.objects.CheckboxThingie;
import funkin.objects.AttachedText;
import funkin.states.options.Option;
import funkin.backend.InputFormatter;

//wip
class BaseOptionsMenu extends MusicBeatSubstate
{
	private var curOption:Option = null;
	private var curSelected:Int = 0;
	var optionsArray:Array<Option>;

	var grpOptions:Array<FlxText> = [];
	private var checkboxGroup:FlxTypedGroup<CheckboxThingie>;
	private var grpTexts:FlxTypedGroup<FlxText>;

	private var descBox:FlxSprite;
	private var descText:FlxText;

	public var title:String;
	public var rpcTitle:String;

	var selectd:FlxText;

	var optionCamera:FlxCamera;
	var optionText:FlxText;

	var border:FlxSprite;
	public function new()
	{
		super();

		if(title == null) title = 'Options';
		if(rpcTitle == null) rpcTitle = 'Options Menu';
		
		#if DISCORD_ALLOWED
		DiscordClient.changePresence(rpcTitle, null);
		#end

		optionCamera = funkin.states.Title.quickCreateCam();

		var bg = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		bg.scale.set(FlxG.width, FlxG.height);
		bg.updateHitbox();
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		FlxTween.tween(bg,{alpha:0.85},0.5);

		// avoids lagspikes while scrolling through menus!
		//grpOptions = new FlxTypedGroup<Alphabet>();
		//add(grpOptions);

		checkboxGroup = new FlxTypedGroup<CheckboxThingie>();
		add(checkboxGroup);

		grpTexts = new FlxTypedGroup<FlxText>();
		add(grpTexts);

		for (i in 0...optionsArray.length)
		{
			optionText = new FlxText(0, 0, FlxG.width, optionsArray[i].name);
			optionText.setFormat(Paths.font("Digiface Regular.ttf"), 70, FlxColor.GREEN, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			optionText.screenCenter();
			optionText.y += (100 * (i - (optionsArray.length / 2))) + 393;
			optionText.cameras = [optionCamera];
			add(optionText);
			grpOptions.push(optionText);
			
			if (optionsArray[i].type == 'bool')
			{
				var checkbox:CheckboxThingie = new CheckboxThingie(optionText.x + optionText.width - 430, optionText.y - 1, Std.string(optionsArray[i].getValue()) == 'true');
				checkbox.ID = i;
				checkbox.cameras = [optionCamera];
				checkboxGroup.add(checkbox);
			}
			else
			{
				var valueText = new FlxText(optionText.x - 340, optionText.y, FlxG.width, '' + optionsArray[i].getValue());
				valueText.setFormat(Paths.font("Digiface Regular.ttf"), 60, FlxColor.LIME, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				valueText.ID = i;
				valueText.cameras = [optionCamera];
				grpTexts.add(valueText);
				optionsArray[i].child = valueText;
			}
			updateTextFrom(optionsArray[i]);
		}

		selectd = new FlxText(965, 288, 0, '<');
		selectd.setFormat(Paths.font("Digiface Regular.ttf"), 70, FlxColor.LIME, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(selectd);

		changeSelection();
		reloadCheckboxes();

		border = new FlxSprite().loadImage('menus/border');
		border.scale.set(0.72, 0.72);
		border.screenCenter();
		border.cameras = [funkin.states.Title.quickCreateCam()];
		border.scrollFactor.set();
		add(border);
	}

	public function addOption(option:Option) 
	{
		if(optionsArray == null || optionsArray.length < 1) optionsArray = [];
		optionsArray.push(option);
		return option;
	}

	var nextAccept:Int = 5;
	var holdTime:Float = 0;
	var holdValue:Float = 0;
	
	var bindingKey:Bool = false;
	var holdingEsc:Float = 0;
	var bindingBlack:FlxSprite;
	var bindingText:Alphabet;
	var bindingText2:Alphabet;
	
	override function update(elapsed:Float)
	{
		final lerpRate:Float = 1 - Math.exp(-elapsed * 26);

		super.update(elapsed);
		
		if (bindingKey)
		{
			bindingKeyUpdate(elapsed);
			return;
		}

		if (controls.UI_UP_P || controls.UI_DOWN_P) changeSelection(controls.UI_UP_P ? -1 : 1);

		if(FlxG.mouse.wheel != 0)
		{
			changeSelection(-1 * FlxG.mouse.wheel);
		}
		
		if (controls.BACK)
		{
			close();
			FlxG.sound.play(Paths.sound('spaceunpause'));
		}
		
		if (nextAccept <= 0)
		{
			if (curOption.type == 'bool')
			{
				if (controls.ACCEPT)
				{
					FlxG.sound.play(Paths.sound('scrollup1'));
					curOption.setValue((curOption.getValue() == true) ? false : true);
					curOption.change();
					reloadCheckboxes();
				}
			}
			else
			{
				if (curOption.type == 'keybind')
				{
					if (controls.ACCEPT)
					{
						bindingBlack = new FlxSprite().makeGraphic(1, 1, FlxColor.WHITE);
						bindingBlack.scale.set(FlxG.width, FlxG.height);
						bindingBlack.updateHitbox();
						bindingBlack.alpha = 0;
						FlxTween.tween(bindingBlack, {alpha: 0.6}, 0.35, {ease: FlxEase.linear});
						add(bindingBlack);
						
						bindingText = new Alphabet(FlxG.width / 2, 160, "Rebinding " + curOption.name, false);
						bindingText.alignment = CENTERED;
						add(bindingText);
						
						bindingText2 = new Alphabet(FlxG.width / 2, 340, "Hold ESC to Cancel\nHold Backspace to Delete", true);
						bindingText2.alignment = CENTERED;
						add(bindingText2);
						
						bindingKey = true;
						holdingEsc = 0;
						ClientPrefs.toggleVolumeKeys(false);
						FlxG.sound.play(Paths.sound('scrollup1'));
					}
				}
				else if (controls.UI_LEFT || controls.UI_RIGHT)
				{
					var pressed = (controls.UI_LEFT_P || controls.UI_RIGHT_P);
					if (holdTime > 0.5 || pressed)
					{
						if (pressed)
						{
							var add:Dynamic = null;
							if (curOption.type != 'string') add = controls.UI_LEFT ? -curOption.changeValue : curOption.changeValue;
							
							switch (curOption.type)
							{
								case 'int' | 'float' | 'percent':
									holdValue = curOption.getValue() + add;
									if (holdValue < curOption.minValue) holdValue = curOption.minValue;
									else if (holdValue > curOption.maxValue) holdValue = curOption.maxValue;
									
									switch (curOption.type)
									{
										case 'int':
											holdValue = Math.round(holdValue);
											curOption.setValue(holdValue);
											
										case 'float' | 'percent':
											holdValue = FlxMath.roundDecimal(holdValue, curOption.decimals);
											curOption.setValue(holdValue);
									}
									
								case 'string':
									var num:Int = curOption.curOption; // lol
									if (controls.UI_LEFT_P) --num;
									else num++;
									
									if (num < 0) num = curOption.options.length - 1;
									else if (num >= curOption.options.length) num = 0;
									
									curOption.curOption = num;
									curOption.setValue(curOption.options[num]); // lol
									// trace(curOption.options[num]);
							}
							updateTextFrom(curOption);
							curOption.change();
							FlxG.sound.play(Paths.sound('scrollup1'));
						}
						else if (curOption.type != 'string')
						{
							holdValue += curOption.scrollSpeed * elapsed * (controls.UI_LEFT ? -1 : 1);
							if (holdValue < curOption.minValue) holdValue = curOption.minValue;
							else if (holdValue > curOption.maxValue) holdValue = curOption.maxValue;
							
							switch (curOption.type)
							{
								case 'int':
									curOption.setValue(Math.round(holdValue));
									
								case 'float' | 'percent':
									curOption.setValue(FlxMath.roundDecimal(holdValue, curOption.decimals));
							}
							updateTextFrom(curOption);
							curOption.change();
						}
					}
					
					if (curOption.type != 'string') holdTime += elapsed;
				}
				else if (controls.UI_LEFT_R || controls.UI_RIGHT_R)
				{
					if (holdTime > 0.5) FlxG.sound.play(Paths.sound('scrollup1'));
					holdTime = 0;
				}
			}
			
			if (controls.RESET)
			{
				var leOption:Option = optionsArray[curSelected];
				if (leOption.type != 'keybind')
				{
					leOption.setValue(leOption.defaultValue);
					if (leOption.type != 'bool')
					{
						if (leOption.type == 'string') leOption.curOption = leOption.options.indexOf(leOption.getValue());
						updateTextFrom(leOption);
					}
				}
				else
				{
					leOption.setValue(!Controls.instance.controllerMode ? leOption.defaultKeys.keyboard : leOption.defaultKeys.gamepad);
					updateBind(leOption);
				}
				leOption.change();
				FlxG.sound.play(Paths.sound('spaceunpause'));
				reloadCheckboxes();
			}
		}
		
		if (nextAccept > 0)
		{
			nextAccept -= 1;
		}
	}
	
	function bindingKeyUpdate(elapsed:Float)
	{
		if (FlxG.keys.pressed.ESCAPE || FlxG.gamepads.anyPressed(B))
		{
			holdingEsc += elapsed;
			if (holdingEsc > 0.5)
			{
				FlxG.sound.play(Paths.sound('spaceunpause'));
				closeBinding();
			}
		}
		else if (FlxG.keys.pressed.BACKSPACE || FlxG.gamepads.anyPressed(BACK))
		{
			holdingEsc += elapsed;
			if (holdingEsc > 0.5)
			{
				if (!controls.controllerMode) curOption.keys.keyboard = NONE;
				else curOption.keys.gamepad = NONE;
				updateBind(!controls.controllerMode ? InputFormatter.getKeyName(NONE) : InputFormatter.getGamepadName(NONE));
				FlxG.sound.play(Paths.sound('spaceunpause'));
				closeBinding();
			}
		}
		else
		{
			holdingEsc = 0;
			var changed:Bool = false;
			if (!controls.controllerMode)
			{
				if (FlxG.keys.justPressed.ANY || FlxG.keys.justReleased.ANY)
				{
					var keyPressed:FlxKey = cast(FlxG.keys.firstJustPressed(), FlxKey);
					var keyReleased:FlxKey = cast(FlxG.keys.firstJustReleased(), FlxKey);
					
					if (keyPressed != NONE && keyPressed != ESCAPE && keyPressed != BACKSPACE)
					{
						changed = true;
						curOption.keys.keyboard = keyPressed;
					}
					else if (keyReleased != NONE && (keyReleased == ESCAPE || keyReleased == BACKSPACE))
					{
						changed = true;
						curOption.keys.keyboard = keyReleased;
					}
				}
			}
			else if (FlxG.gamepads.anyJustPressed(ANY)
				|| FlxG.gamepads.anyJustPressed(LEFT_TRIGGER)
				|| FlxG.gamepads.anyJustPressed(RIGHT_TRIGGER)
				|| FlxG.gamepads.anyJustReleased(ANY))
			{
				var keyPressed:FlxGamepadInputID = NONE;
				var keyReleased:FlxGamepadInputID = NONE;
				if (FlxG.gamepads.anyJustPressed(LEFT_TRIGGER)) keyPressed = LEFT_TRIGGER; // it wasnt working for some reason
				else if (FlxG.gamepads.anyJustPressed(RIGHT_TRIGGER)) keyPressed = RIGHT_TRIGGER; // it wasnt working for some reason
				else
				{
					for (i in 0...FlxG.gamepads.numActiveGamepads)
					{
						var gamepad:FlxGamepad = FlxG.gamepads.getByID(i);
						if (gamepad != null)
						{
							keyPressed = gamepad.firstJustPressedID();
							keyReleased = gamepad.firstJustReleasedID();
							if (keyPressed != NONE || keyReleased != NONE) break;
						}
					}
				}
				
				if (keyPressed != NONE && keyPressed != FlxGamepadInputID.BACK && keyPressed != FlxGamepadInputID.B)
				{
					changed = true;
					curOption.keys.gamepad = keyPressed;
				}
				else if (keyReleased != NONE && (keyReleased == FlxGamepadInputID.BACK || keyReleased == FlxGamepadInputID.B))
				{
					changed = true;
					curOption.keys.gamepad = keyReleased;
				}
			}
			
			if (changed)
			{
				var key:String = null;
				if (!controls.controllerMode)
				{
					if (curOption.keys.keyboard == null) curOption.keys.keyboard = 'NONE';
					curOption.setValue(curOption.keys.keyboard);
					key = InputFormatter.getKeyName(FlxKey.fromString(curOption.keys.keyboard));
				}
				else
				{
					if (curOption.keys.gamepad == null) curOption.keys.gamepad = 'NONE';
					curOption.setValue(curOption.keys.gamepad);
					key = InputFormatter.getGamepadName(FlxGamepadInputID.fromString(curOption.keys.gamepad));
				}
				updateBind(key);
				FlxG.sound.play(Paths.sound('enterimpact'));
				closeBinding();
			}
		}
	}
	
	final MAX_KEYBIND_WIDTH = 320;
	
	function updateBind(?text:String = null, ?option:Option = null)
	{
		if (option == null) option = curOption;
		if (text == null)
		{
			text = option.getValue();
			if (text == null) text = 'NONE';
			
			if (!controls.controllerMode) text = InputFormatter.getKeyName(FlxKey.fromString(text));
			else text = InputFormatter.getGamepadName(FlxGamepadInputID.fromString(text));
		}
		
		var bind:AttachedText = cast option.child;
		var attach:AttachedText = new AttachedText(text, bind.offsetX);
		attach.sprTracker = bind.sprTracker;
		attach.copyAlpha = true;
		attach.ID = bind.ID;
		playstationCheck(attach);
		attach.scaleX = Math.min(1, MAX_KEYBIND_WIDTH / attach.width);
		attach.x = bind.x;
		attach.y = bind.y;
		
		// option.child = attach;
		// grpTexts.insert(grpTexts.members.indexOf(bind), attach);
		// grpTexts.remove(bind);
		bind.destroy();
	}
	
	function playstationCheck(alpha:Alphabet)
	{
		if (!controls.controllerMode) return;
		
		var gamepad:FlxGamepad = FlxG.gamepads.firstActive;
		var model:FlxGamepadModel = gamepad != null ? gamepad.detectedModel : UNKNOWN;
		var letter = alpha.letters[0];
		if (model == PS4)
		{
			switch (alpha.text)
			{
				case '[', ']': // Square and Triangle respectively
					letter.image = 'alphabet_playstation';
					letter.updateHitbox();
					
					letter.offset.x += 4;
					letter.offset.y -= 5;
			}
		}
	}
	
	function closeBinding()
	{
		bindingKey = false;
		bindingBlack.destroy();
		remove(bindingBlack);
		
		bindingText.destroy();
		remove(bindingText);
		
		bindingText2.destroy();
		remove(bindingText2);
		ClientPrefs.toggleVolumeKeys(true);
	}
	
	function updateTextFrom(option:Option)
	{
		if (option.type == 'keybind')
		{
			updateBind(option);
			return;
		}
		
		var text:String = option.displayFormat;
		var val:Dynamic = option.getValue();
		if (option.type == 'percent') val *= 100;
		var def:Dynamic = option.defaultValue;
		option.text = text.replace('%v', val).replace('%d', def);
	}
	
	function changeSelection(change:Int = 0)
	{
		if (change != 0) FlxG.sound.play(Paths.sound('scrollup1'));
		
		FlxTween.cancelTweensOf(selectd, ['x']);

		grpOptions[curSelected].color = FlxColor.GREEN;
		curSelected = FlxMath.wrap(curSelected + change, 0, optionsArray.length - 1);
		grpOptions[curSelected].color = FlxColor.LIME;
		
		curOption = optionsArray[curSelected]; // shorter lol

		optionCamera.follow(grpOptions[curSelected]);

		selectd.x -= 5;
		FlxTween.tween(selectd, {x: 965}, 0.10, {ease: FlxEase.sineOut});
	}
	
	function reloadCheckboxes()
	{
		for (checkbox in checkboxGroup)
		{
			checkbox.daValue = (optionsArray[checkbox.ID].getValue() == true);
		}
	}
}
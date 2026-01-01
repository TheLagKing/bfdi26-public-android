package funkin.substates;

import funkin.objects.AttachedText;
import funkin.objects.CheckboxThingie;

class OptionsText extends FlxText
{
    public function new(x:Float = 0,y:Float = 0,fWidth:Float = 0,text:String = '',size:Int = 24,color:FlxColor = FlxColor.WHITE)
    {
        super(x,y,fWidth,text,size);

        font = Paths.font('Digiface Regular.ttf');
        this.color = color;
        this.borderStyle = OUTLINE;
		this.borderColor = FlxColor.BLACK;
    }
}

class ScrollingOptionsText extends OptionsText
{
	public var flooredPos:Bool = false;
	public var changeX:Bool = false;
	public var changeY:Bool = true;
	public var isMenuItem:Bool = false;
	public var targetY:Int = 0;
	
	public var distancePerItem:FlxPoint = new FlxPoint(20, 120);
	public var startPosition:FlxPoint = new FlxPoint(0, 0); //for the calculations

	public function new(x:Float = 0,y:Float = 0,text:String = '',size:Int = 40) 
	{
		super(x,y,0,text,size);

		this.startPosition.x = x;
		this.startPosition.y = y;
		this.borderStyle = FlxTextBorderStyle.OUTLINE;
		this.borderColor = FlxColor.BLACK;

		updateHitbox();
	}

	override function update(elapsed:Float)
	{
		if (isMenuItem)
		{
			var lerpVal:Float = Math.exp(-elapsed * 9.6);
			if(changeX)
				x = FlxMath.lerp((targetY * distancePerItem.x) + startPosition.x, x, lerpVal);
			if(changeY)
				y = FlxMath.lerp((targetY * 1.3 * distancePerItem.y) + startPosition.y, y, lerpVal);

			if (flooredPos) //lie
			{
				x = Math.round(x);
				y = Math.round(y);
			}
		}
		super.update(elapsed);
	}
	
	public function snapToPosition()
	{
		if (isMenuItem)
		{
			if(changeX)
				x = (targetY * distancePerItem.x) + startPosition.x;
			if(changeY)
				y = (targetY * 1.3 * distancePerItem.y) + startPosition.y;
		}
	}

}

class AttachedOptionsText extends OptionsText
{
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var sprTracker:FlxSprite;
	public var copyVisible:Bool = true;
	public var copyAlpha:Bool = false;

	public function new(text:String = "", ?offsetX:Float = 0, ?offsetY:Float = 0,?size:Int = 40, ?bold = 1) 
	{
		super(0, 0,0, text,size);
		this.borderStyle = OUTLINE;
		this.borderColor = FlxColor.BLACK;
		this.alignment = CENTER;

		this.offsetX = offsetX;
		this.offsetY = offsetY;
	}

	override function update(elapsed:Float) 
	{
		if (sprTracker != null) 
		{
			setPosition(sprTracker.x + offsetX, sprTracker.y + offsetY);
			
			if(copyVisible) 
				visible = sprTracker.visible;
			if(copyAlpha) 
				alpha = sprTracker.alpha;
		}

		super.update(elapsed);
	}
}

class GameplayChangersSubstate extends MusicBeatSubstate
{
	private var curOption:GameplayOption = null;
	private var curSelected:Int = 0;
	private var optionsArray:Array<Dynamic> = [];

	private var grpOptions:FlxTypedGroup<ScrollingOptionsText>;
	private var checkboxGroup:FlxTypedGroup<CheckboxThingie>;
	private var grpTexts:FlxTypedGroup<AttachedOptionsText>;

	var bg:FlxSprite;

	function getOptions()
	{
		var goption:GameplayOption = new GameplayOption('Scroll Type:', 'scrolltype', 'string', 'multiplicative', ["multiplicative", "constant"]);
		optionsArray.push(goption);

		var option:GameplayOption = new GameplayOption('Scroll Speed:', 'scrollspeed', 'float', 1);
		option.scrollSpeed = 2.0;
		option.minValue = 0.35;
		option.changeValue = 0.05;
		option.decimals = 2;

		if (goption.getValue() != "constant")
		{
			option.displayFormat = '%vX';
			option.maxValue = 3;
		}
		else
		{
			option.displayFormat = "%v";
			option.maxValue = 6;
		}
		optionsArray.push(option);

		#if FLX_PITCH
		var option:GameplayOption = new GameplayOption('Playback Rate:', 'songspeed', 'float', 1);
		option.scrollSpeed = 1;
		option.minValue = 0.5;
		option.maxValue = 3.0;
		option.changeValue = 0.05;
		option.displayFormat = '%vX';
		option.decimals = 2;
		optionsArray.push(option);
		#end

		var option:GameplayOption = new GameplayOption('Health Gain Multiplier:', 'healthgain', 'float', 1);
		option.scrollSpeed = 2.5;
		option.minValue = 0;
		option.maxValue = 5;
		option.changeValue = 0.1;
		option.displayFormat = '%vX';
		optionsArray.push(option);

		var option:GameplayOption = new GameplayOption('Health Loss Multiplier:', 'healthloss', 'float', 1);
		option.scrollSpeed = 2.5;
		option.minValue = 0.5;
		option.maxValue = 5;
		option.changeValue = 0.1;
		option.displayFormat = '%vX';
		optionsArray.push(option);

		optionsArray.push(new GameplayOption('Instakill on Miss:', 'instakill', 'bool', false));
		optionsArray.push(new GameplayOption('Practice Mode:', 'practice', 'bool', false));
		optionsArray.push(new GameplayOption('Botplay:', 'botplay', 'bool', false));
		optionsArray.push(new GameplayOption('Light Mode:', 'lightMode', 'bool', ClientPrefs.data.lightMode));
		//optionsArray.push(new Option('Light Mode', '', 'lightMode', 'bool'));
	}

	public function getOptionByName(name:String)
	{
		for(i in optionsArray)
		{
			var opt:GameplayOption = i;
			if (opt.name == name) return opt;
		}
		return null;
	}

	public function new()
	{
		super();

		var bg = new FlxSprite(1600).makeGraphic(FlxG.width, FlxG.height, (ClientPrefs.data.lightMode ? 0xFFb5b6b5 : 0xFF272727));
		bg.scrollFactor.set();
		bg.alpha = 0.3;
		add(bg);

		FlxTween.tween(bg, {x: 0}, 1, {ease: FlxEase.cubeIn});

		var bg = new FlxSprite(1400).makeGraphic(FlxG.width, FlxG.height, FlxG.camera.bgColor);
		bg.scrollFactor.set();
		bg.alpha = 0.8;
		add(bg);

		FlxTween.tween(bg, {x: 0}, 1, {ease: FlxEase.cubeIn, startDelay: 0.4});

		var settings = new FlxSprite(FlxG.width - 105, 35).loadImage('menus/freeplay/settings');
		settings.antialiasing = ClientPrefs.data.antialiasing;
		settings.setScale(0.15);
		settings.color = ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE;
		add(settings);

		var text = new OptionsText(FlxG.width - 350, FlxG.height - 30, 0, '(Press R to reset to default settings!)', 20);
		text.alpha = 0;
		text.scrollFactor.set();
		add(text);

		FlxTween.tween(text, {alpha: 0.6}, 1.6, {type: FlxTweenType.PINGPONG});

		// avoids lagspikes while scrolling through menus!
		grpOptions = new FlxTypedGroup<ScrollingOptionsText>();
		add(grpOptions);

		grpTexts = new FlxTypedGroup<AttachedOptionsText>();
		add(grpTexts);

		checkboxGroup = new FlxTypedGroup<CheckboxThingie>();
		add(checkboxGroup);
		
		getOptions();

		for (i in 0...optionsArray.length)
		{
			var optionText:ScrollingOptionsText = new ScrollingOptionsText(35, 185.5, optionsArray[i].name);
			optionText.distancePerItem.y = 70;
			optionText.isMenuItem = true;

			optionText.targetY = i;
			optionText.changeX = false;
			optionText.flooredPos = true;

			grpOptions.add(optionText);

			if (optionsArray[i].type == 'bool') 
			{
				var checkbox:CheckboxThingie = new CheckboxThingie(650, 0, Std.string(optionsArray[i].getValue()) == 'true');
				checkbox.sprTracker = optionText;
				checkbox.offsetX = optionText.width + 150;
				checkbox.offsetY = -40;
				checkbox.ID = i;
				checkboxGroup.add(checkbox);
			} 
			else 
			{
				var valueText:AttachedOptionsText = new AttachedOptionsText('' + optionsArray[i].getValue(), optionText.width + 20);
				valueText.sprTracker = optionText;
				valueText.copyAlpha = true;
				valueText.ID = i;
				grpTexts.add(valueText);

				optionsArray[i].setChild(valueText);
			}
			updateTextFrom(optionsArray[i]);
		}

		changeSelection();
		reloadCheckboxes();
	}

	var nextAccept:Int = 5;
	var holdTime:Float = 0;
	var holdValue:Float = 0;
	var able:Bool = true;
	
	override function update(elapsed:Float)
	{
		if ((controls.UI_UP_P || controls.UI_DOWN_P) && able) changeSelection(controls.UI_UP_P ? -1 : 1);

		if (controls.BACK && able) 
		{
			close();

			ClientPrefs.saveSettings();
			FlxG.sound.play(Paths.sound('spaceunpause'));
		}

		if (nextAccept <= 0)
		{
			var usesCheckbox = true;
			if (curOption.type != 'bool') usesCheckbox = false;

			if (usesCheckbox)
			{
				if (controls.ACCEPT && able)
				{
					FlxG.sound.play(Paths.sound('scrollup1'));
					curOption.setValue((curOption.getValue() == true) ? false : true);
					curOption.change();
					reloadCheckboxes();

					if (curOption.name == 'Light Mode:') 
					{
						able = false;

						FlxTimer.wait(0.7, () -> 
						{
							ClientPrefs.data.lightMode = curOption.getValue();
							ClientPrefs.saveSettings();
						
							var screen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, ((curOption.getValue() == true) ? 0xFFe0e0e0 : 0xFF121212));
							screen.alpha = 0;
							screen.scrollFactor.set();
							add(screen);

							FlxTween.tween(FlxG.sound.music, {pitch: (curOption.getValue() == true) ? 1.4 : 0.3}, 1.2, {ease: FlxEase.cubeOut});
							FlxTween.tween(screen, {alpha: 1}, 1.3, {ease: FlxEase.cubeIn, onComplete:_ -> 
							{
								//close();
								FlxG.sound.music.pitch = 1;
								FlxG.sound.music.pause();
								FlxG.sound.music.stop();

								FlxG.sound.playMusic(Paths.music('freeplayMenu'), 1);
								FlxG.switchState(() -> new funkin.states.FreeplayState(true));
							}});
						});
					}
				}
			} 
			else 
			{
				if (controls.UI_LEFT || controls.UI_RIGHT) 
				{
					var pressed = ((controls.UI_LEFT_P || controls.UI_RIGHT_P) && able);

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
									var num:Int = curOption.curOption; //lol
									if (controls.UI_LEFT_P) --num;
									else num++;

									if (num < 0) num = curOption.options.length - 1;
									else if (num >= curOption.options.length) num = 0;

									curOption.curOption = num;
									curOption.setValue(curOption.options[num]); //lol
									
									if (curOption.name == "Scroll Type")
									{
										var oOption:GameplayOption = getOptionByName("Scroll Speed");
										if (oOption != null)
										{
											if (curOption.getValue() == "constant")
											{
												oOption.displayFormat = "%v";
												oOption.maxValue = 6;
											}
											else
											{
												oOption.displayFormat = "%vX";
												oOption.maxValue = 3;
												if(oOption.getValue() > 3) oOption.setValue(3);
											}
											updateTextFrom(oOption);
										}
									}
									//trace(curOption.options[num]);
							}

							updateTextFrom(curOption);
							curOption.change();
							FlxG.sound.play(Paths.sound('scrollup1'));
						} 
						else if (curOption.type != 'string') 
						{
							holdValue = Math.max(curOption.minValue, Math.min(curOption.maxValue, holdValue + curOption.scrollSpeed * elapsed * (controls.UI_LEFT ? -1 : 1)));

							switch (curOption.type)
							{
								case 'int': curOption.setValue(Math.round(holdValue));
								case 'float' | 'percent':
									var blah:Float = Math.max(curOption.minValue, Math.min(curOption.maxValue, holdValue + curOption.changeValue - (holdValue % curOption.changeValue)));
									curOption.setValue(FlxMath.roundDecimal(blah, curOption.decimals));
							}

							updateTextFrom(curOption);
							curOption.change();
						}
					}

					if (curOption.type != 'string') holdTime += elapsed;
				} 
				else if (controls.UI_LEFT_R || controls.UI_RIGHT_R) clearHold();
			}

			if (controls.RESET && able)
			{
				for (i in 0...optionsArray.length)
				{
					var leOption:GameplayOption = optionsArray[i];
					leOption.setValue(leOption.defaultValue);

					if (leOption.type != 'bool')
					{
						if (leOption.type == 'string') leOption.curOption = leOption.options.indexOf(leOption.getValue());
						updateTextFrom(leOption);
					}

					if (leOption.name == 'Scroll Speed')
					{
						leOption.displayFormat = "%vX";
						leOption.maxValue = 3;

						if (leOption.getValue() > 3) leOption.setValue(3);
						updateTextFrom(leOption);
					}

					leOption.change();
				}

				FlxG.sound.play(Paths.sound('spaceunpause'));
				reloadCheckboxes();
			}
		}

		if(nextAccept > 0) nextAccept -= 1;
		super.update(elapsed);
	}

	function updateTextFrom(option:GameplayOption) 
	{
		var text:String = option.displayFormat;
		var val:Dynamic = option.getValue();

		if (option.type == 'percent') val *= 100;

		var def:Dynamic = option.defaultValue;
		option.text = text.replace('%v', val).replace('%d', def);
	}

	function clearHold()
	{
		if (holdTime > 0.5) FlxG.sound.play(Paths.sound('scrollup1'));
		holdTime = 0;
	}
	
	function changeSelection(change:Int = 0)
	{
		curSelected = FlxMath.wrap(curSelected + change,0,optionsArray.length-1);

		for (idx => item in grpOptions.members) 
		{
			item.targetY = idx - curSelected;

			item.alpha = 0.6;
			if (item.targetY == 0) item.alpha = 1;
		}

		for (text in grpTexts) 
		{
			text.alpha = 0.6;
			if (text.ID == curSelected) text.alpha = 1;
		}

		curOption = optionsArray[curSelected]; //shorter lol
		FlxG.sound.play(Paths.sound('scrollup1'));
	}

	function reloadCheckboxes() for (checkbox in checkboxGroup) checkbox.daValue = (optionsArray[checkbox.ID].getValue() == true);
}

class GameplayOption
{
	private var child:AttachedOptionsText;
	public var text(get, set):String;
	public var onChange:Void->Void = null; //Pressed enter (on Bool type options) or pressed/held left/right (on other types)

	public var type(get, default):String = 'bool'; //bool, int (or integer), float (or fl), percent, string (or str)
	// Bool will use checkboxes
	// Everything else will use a text

	public var showBoyfriend:Bool = false;
	public var scrollSpeed:Float = 50; //Only works on int/float, defines how fast it scrolls per second while holding left/right

	private var variable:String = null; //Variable from ClientPrefs.hx's gameplaySettings
	public var defaultValue:Dynamic = null;

	public var curOption:Int = 0; //Don't change this
	public var options:Array<String> = null; //Only used in string type
	public var changeValue:Dynamic = 1; //Only used in int/float/percent type, how much is changed when you PRESS
	public var minValue:Dynamic = null; //Only used in int/float/percent type
	public var maxValue:Dynamic = null; //Only used in int/float/percent type
	public var decimals:Int = 1; //Only used in float/percent type

	public var displayFormat:String = '%v'; //How String/Float/Percent/Int values are shown, %v = Current value, %d = Default value
	public var name:String = 'Unknown';

	public function new(name:String, variable:String, type:String = 'bool', defaultValue:Dynamic = 'null variable value', ?options:Array<String> = null)
	{
		this.name = name;
		this.variable = variable;
		this.type = type;
		this.defaultValue = defaultValue;
		this.options = options;

		if (defaultValue == 'null variable value')
		{
			switch(type)
			{
				case 'bool': defaultValue = false;
				case 'int' | 'float': defaultValue = 0;
				case 'percent': defaultValue = 1;
				case 'string':
					defaultValue = '';
					if(options.length > 0) defaultValue = options[0];
			}
		}

		if (getValue() == null) setValue(defaultValue);

		switch(type)
		{
			case 'string':
				var num:Int = options.indexOf(getValue());
				if(num > -1) curOption = num;
			case 'percent':
				displayFormat = '%v%';
				changeValue = 0.01;
				minValue = 0;
				maxValue = 1;
				scrollSpeed = 0.5;
				decimals = 2;
		}
	}

	public function change() if (onChange != null) onChange();
	public function getValue():Dynamic return ClientPrefs.data.gameplaySettings.get(variable);
	public function setValue(value:Dynamic) ClientPrefs.data.gameplaySettings.set(variable, value);
	public function setChild(child:AttachedOptionsText) this.child = child;

	private function get_text()
	{
		if (child != null) return child.text;
		return null;
	}

	private function set_text(newValue:String = '')
	{
		if (child != null) child.text = newValue;
		return null;
	}

	private function get_type()
	{
		var newValue:String = 'bool';
		switch(type.toLowerCase().trim())
		{
			case 'int' | 'float' | 'percent' | 'string': newValue = type;
			case 'integer': newValue = 'int';
			case 'str': newValue = 'string';
			case 'fl': newValue = 'float';
		}

		type = newValue;
		return type;
	}
}
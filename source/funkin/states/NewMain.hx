package funkin.states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import funkin.states.editors.MasterEditorMenu;
import funkin.states.options.OptionsState;
import funkin.data.Highscore;
import funkin.objects.Character;

import flixel.input.mouse.FlxMouseEvent;

class NewMain extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.3'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var selectedSomethin:Bool = true;

	public var menuItems:FlxTypedGroup<FlxSprite>;
	final buttons:Array<String> = ["mainsongs","freeplay","options","credits","website"];

	var tv:Character;
	final bgs = ['exit','plains','beam','ruins','hpprc'];

	override function create()
	{
		FlxG.mouse.visible = true;
		FlxG.camera.bgColor = FlxColor.BLACK;

		#if DISCORD_ALLOWED DiscordClient.changePresence("BFDI 26 - MAIN MENU", null); #end
		Mods.loadTopMod();
		Difficulty.resetList();

		var rd = FlxG.random.getObject(bgs);
		var bg = new FlxSprite().loadImage('menus/main/bgs/${rd}');
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.screenCenter();
		bg.x += 30;
		bg.scrollFactor.set(0.7,0.7);
		bg.alpha = 0.1;
		add(bg);
		
		FlxTween.tween(bg, {alpha: 1,x: bg.x+20}, 0.7, {ease: FlxEase.quadInOut, startDelay: 0.3});

		FlxTimer.wait(0, () -> { //idk why but if im not using timer it js doesnt tween but ill look into that later
			FlxG.camera.zoom = 2;

			@:privateAccess 
			{
				FlxG.camera._fxFadeColor = FlxColor.BLACK;
				FlxG.camera._fxFadeAlpha = 1;
			}

			FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 0},1.5);
			FlxTween.tween(FlxG.camera,{zoom: 1},1.7,{ease: FlxEase.sineOut, onComplete:Void -> selectedSomethin = false});
		});

		if (rd == 'plains') bg.scale.set(0.8,0.8); 
		else if (rd != 'ruins') bg.scale.set(0.7,0.7);
		
		if (rd == 'beam') FlxTween.tween(bg, {alpha: 1, x: bg.x, y: bg.y-30}, 0.7, {ease: FlxEase.quadInOut, startDelay: 0.3});
		if (rd == 'hpprc') FlxTween.tween(bg, {alpha: 1, x: bg.x-40}, 0.7, {ease: FlxEase.quadInOut, startDelay: 0.3});
		if (rd == 'exit') FlxTween.tween(bg, {alpha: 1, x: bg.x-20}, 0.7, {ease: FlxEase.quadInOut, startDelay: 0.3});

		if ((Highscore.getSongData('yoylefake',1).songScore <= 0) && !FlxG.save.data.welcome2) buttons.remove('freeplay'); //checks if you've never beaten yoylefake before and therefore locking freeplay

		menuItems = new FlxTypedGroup<FlxSprite>();
		for (i in 0...buttons.length)
		{
			var menuItem = new FlxSprite(650,(buttons.length > 4 ? 140 : 180) + (i * (60 + 30))).loadFrames('menus/main/buttons');

			menuItem.addAnimByPrefix('i', '${buttons[i]} instance 1');
			menuItem.addAnimByPrefix('s', '${buttons[i]} selected instance 1');
			menuItem.animation.play('i');
			
			menuItem.scale.set(0.6,0.6);
			menuItem.updateHitbox();
			menuItem.scrollFactor.set(0.9,0.9);
			
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.ID = i;
			menuItems.add(menuItem);
		}
		add(menuItems);

		tv = new Character(menuItems.members[0].x-300, 422, 'tv');
        tv.scrollFactor.set(0.8,0.8);
		tv.antialiasing = true;
		tv.alpha = 0.0001;
        add(tv);

		changeItem();

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.alpha = 0;
			spr.x += 30;
			FlxTween.tween(spr, {alpha: 1,x:spr.x+30}, 0.8, {ease: FlxEase.backOut,startDelay: spr.ID*0.1});
		});
		FlxTween.tween(tv,{alpha: 1,y: tv.y+25},0.6,{ease: FlxEase.backOut,startDelay: 0.6});

		var version = new FlxText(0, 0, FlxG.width, 'BFDI 26 V1.7 - Character Mix Update', 20);
		version.setFormat(Paths.font("YouTubeSansRegular.otf"), 20, FlxColor.WHITE);
		version.scrollFactor.set(0,0);
		version.y = 690;
		add(version);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.FOUR) FlxG.resetState();

		mouseMovement(elapsed,!selectedSomethin);

		if (!selectedSomethin) 
		{
			if (controls.UI_UP_P || controls.UI_DOWN_P) changeItem(controls.UI_UP_P ? -1 : 1);
			if (FlxG.mouse.wheel != 0) changeItem(-1 * FlxG.mouse.wheel);

			if (controls.BACK || FlxG.mouse.justPressedRight)
			{
				FlxG.sound.play(Paths.sound('spaceunpause'));
				selectedSomethin = true;
				FlxG.switchState(new funkin.states.Title());
				FlxG.mouse.visible = false;
			}

			var isOverSmth:Bool = false;

			for(i in menuItems)
			{ 
				final itemID = menuItems.members.indexOf(i);
				final isOverlapping = FlxG.mouse.overlaps(i);

				if (isOverlapping)
				{
					isOverSmth = true;
					if (FlxG.mouse.justMoved && curSelected != itemID)
					{
						changeItem(itemID - curSelected);
					}
				}
					
				if (controls.ACCEPT || (FlxG.mouse.justPressed && isOverlapping)) 
				{
					isOverSmth = false;
					confirm(buttons[curSelected]);
				}
			}

			FlxG.mouse.load((isOverSmth ? Setup.mouseHover : Setup.mouseIdle), 0.12);
		}

		super.update(elapsed);
	}	

	function changeItem(change:Int = 0)
	{
		if(change != 0) FlxG.sound.play(Paths.sound('scrollup1'));

		menuItems.members[curSelected].animation.play('i');
		curSelected = FlxMath.wrap(curSelected+change,0,menuItems.length-1);
		menuItems.members[curSelected].animation.play('s');

		tv.playAnim('${buttons[curSelected]}');
	}

	function confirm(button:String) 
	{
		selectedSomethin = true;

		if (button == 'mainsongs') 
		{
			FlxTween.tween(FlxG.sound.music, {pitch: 3}, 0.1, {onComplete:Void -> FlxTween.tween(FlxG.sound.music, {pitch: FlxG.random.float(0.4, 0.9)}, 0.3)});
			FlxTween.tween(FlxG.camera,{zoom: 1.1},0.4,{ease: FlxEase.backOut, onComplete:Void -> openSubState(new SongSelect())});
		}
		else 
		{
			//FlxG.sound.play(Paths.sound('enterimpact'),0.4);

			FlxTween.tween(FlxG.camera,{zoom: 3},1.6,{ease: FlxEase.sineOut});
			FlxTween.tween(FlxG.camera.scroll,{x: -350, y: 10},1.6,{ease: FlxEase.sineOut});
			FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 1},0.6,{startDelay: 0.3, onComplete:Void -> 
			{
				switch(button) 
				{
					case "freeplay":
						FlxG.sound.music.fadeOut(0.5, 0, (tw) -> 
						{
							FlxG.sound.music.stop();
							FlxG.switchState(()-> new FreeplayState());
						});
					case "website": 
						CoolUtil.browserLoad('https://discord.gg/yoylefake'); //more convenient
						FlxG.resetState();
					case "options": 
						OptionsState.onPlayState = false;
						FlxG.switchState(funkin.states.options.OptionsState.new);
					case "credits": 							
						FlxG.sound.music.fadeOut(0.3);
						FlxG.switchState(funkin.states.CreditsState.new);
				}
			}});
		}
	}

	function mouseMovement(elapsed:Float, work:Bool) 
	{ //luv u vechett
		if (work) 
		{
			var mouseX = (FlxG.mouse.getScreenPosition(FlxG.camera).x - (FlxG.width/2)) / 14;
			var mouseY = (FlxG.mouse.getScreenPosition(FlxG.camera).y - (FlxG.height/2)) / 14;
			
			FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (mouseX), 1-Math.exp(-elapsed * 3));
			FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (mouseY),1-Math.exp(-elapsed * 3));
		} else return;
	}
}

class SongSelect extends MusicBeatSubstate 
{
	final song:Array<String> = ["yoylefake","locked","locked"]; //idc fuck all
	public static var songSpr:FlxTypedGroup<FlxSprite>;
	public static var current:Int = 0;

	var sle:Bool = false;
	var blackbg:FlxSprite;

	public function new() super();

	override function create()
	{
		blackbg = new FlxSprite().generateGraphic(FlxG.width, FlxG.height);
		blackbg.screenCenter();
		blackbg.scrollFactor.set();
		blackbg.color = FlxColor.BLACK;
		blackbg.alpha = 0;
		add(blackbg);

		FlxTween.tween(blackbg,{alpha: 0.8},1,{ease: FlxEase.backOut});

		songSpr = new FlxTypedGroup<FlxSprite>();
		for (i in 0...song.length)
		{
			var menuItem = new FlxSprite(0,0).loadImage('menus/main/select/${song[i]}');
			menuItem.scale.set(0.26,0.26);
			menuItem.scrollFactor.set(0.98,0.98);
			menuItem.screenCenter();
			menuItem.x += (360 * (i - (song.length / 2))) + 570;
			menuItem.y = 130;
			menuItem.updateHitbox();
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.ID = i;
			songSpr.add(menuItem);
		}
		add(songSpr);

		songSpr.forEach(function(spr:FlxSprite)
		{
			spr.y -= 700;
			FlxTween.tween(spr, {y:spr.y+700}, 1.5, {ease: FlxEase.backOut,startDelay: spr.ID*0.2, onComplete:Void->sle = true});
		});

		cursel();
		super.create();
	}

	override function update(elapsed:Float) 
	{
		mouseMovement(elapsed);

		if (controls.UI_LEFT_P || controls.UI_RIGHT_P) cursel(controls.UI_LEFT_P ? -1 : 1);

		if (sle) 
		{
			var isOverSmth:Bool = false;

			for(i in songSpr)
			{ 
				final itemID = songSpr.members.indexOf(i);
				final isOverlapping = FlxG.mouse.overlaps(i);

				if (isOverlapping)
				{
					isOverSmth = true;
					if (FlxG.mouse.justMoved && current != itemID)
					{
						cursel(itemID - current);
					}
				}
					
				if (controls.ACCEPT || (FlxG.mouse.justPressed && isOverlapping)) 
				{
					isOverSmth = false;
					accept(song[current]);
				}
			}

			FlxG.mouse.load((isOverSmth ? Setup.mouseHover : Setup.mouseIdle), 0.12);

			if (controls.BACK || FlxG.mouse.justPressedRight)
			{
				songSpr.forEach(function(spr:FlxSprite)
				{
					FlxTween.tween(spr, {y:spr.y+700}, 1.5, {ease: FlxEase.backOut,startDelay: spr.ID*0.2});
				});

				//jesus
				FlxTween.tween(FlxG.sound.music, {pitch: 3}, 0.4, {startDelay: 0.5,onComplete:Void->{
					FlxTween.tween(FlxG.sound.music, {pitch: FlxG.random.float(0.6, 1.3)}, 0.3, {onComplete:Void->{
						FlxTween.tween(FlxG.sound.music, {pitch: 1}, 0.2);
						FlxTween.tween(blackbg,{alpha: 0},0.2,{ease: FlxEase.backOut, onComplete:Void->{
							FlxTween.tween(FlxG.camera,{zoom: 1},0.2,{ease: FlxEase.backOut});

							funkin.states.NewMain.selectedSomethin = false;
							close();
						}});
					}});
				}});
			}
		}
		super.update(elapsed);
	}

	function cursel(change:Int = 0) current = FlxMath.wrap(current+change,0,songSpr.length-1);
	
	function accept(button:String) 
	{
		switch(button) 
		{
			case "yoylefake": 
				sle = false;

				FlxTween.tween(blackbg, {alpha: 1}, 0.3, {ease: FlxEase.backOut, startDelay: 1,onComplete:Void->yyoelafake()});

				songSpr.forEach(function(spr:FlxSprite)
				{
					FlxTween.tween(spr, {alpha: 0}, 1, {ease: FlxEase.backOut,startDelay: spr.ID*0.3});
				});

				//dear god
				FlxTween.tween(FlxG.sound.music, {pitch: 3}, 0.5, {onComplete:Void->{
					FlxTween.tween(FlxG.sound.music, {pitch: FlxG.random.float(0.6, 1.3)}, 0.3, {onComplete:Void->{
						FlxTween.tween(FlxG.sound.music, {pitch: 1}, 0.4, {onComplete:Void->{
							FlxTween.tween(FlxG.sound.music, {pitch: 3}, 0.2, {onComplete:Void->{
								FlxTween.tween(FlxG.sound.music, {pitch: FlxG.random.float(0.6, 1.3)}, 0.2, {onComplete:Void->{
									FlxTween.tween(FlxG.sound.music, {pitch: 0}, 0.2);
								}});
							}});
						}});
					}});
				}});
			default:
				FlxG.sound.play(Paths.sound('spaceunpause'));
				songSpr.members[current].color = FlxColor.BLACK;
				FlxTween.color(songSpr.members[current], 0.3, FlxColor.BLACK, FlxColor.WHITE);
		}
	}

	function yyoelafake() 
	{
		try
		{
			PlayState.SONG = funkin.backend.Song.loadFromJson(Paths.formatToSongPath('yoylefake'), Highscore.formatSong('yoylefake', 1));
			PlayState.yoylefakeStart = true;
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 1;
			FlxG.switchState(PlayState.new);
		}
		catch (e:Dynamic)
		{
			trace('fuck. $e');
			FlxG.sound.play(Paths.sound('spaceunpause'));
			return;
		}
	
		FlxG.switchState(PlayState.new);
	}

	function mouseMovement(elapsed:Float) 
	{ //luv u vechett
		var mouseX = (FlxG.mouse.getScreenPosition(FlxG.camera).x - (FlxG.width/2)) / 14;
		var mouseY = (FlxG.mouse.getScreenPosition(FlxG.camera).y - (FlxG.height/2)) / 14;
	
		FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (mouseX), 1-Math.exp(-elapsed * 3));
		FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (mouseY),1-Math.exp(-elapsed * 3));
	}
}
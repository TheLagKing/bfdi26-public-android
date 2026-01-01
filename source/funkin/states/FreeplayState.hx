package funkin.states;

import funkin.data.ModSave;
import funkin.data.WeekData;
import funkin.data.Highscore;

import funkin.backend.Song;
import funkin.objects.Character;
import funkin.backend.FlxTextTyper;
import funkin.scripting.ModchartSprite;

import sys.io.File;
import sys.io.Process;

import Sys;
import openfl.Lib;
import lime.app.Application;

import flixel.util.FlxGradient;
import flixel.util.FlxStringUtil;

import flixel.effects.FlxFlicker;
import flixel.input.mouse.FlxMouseEvent;
import flixel.system.FlxAssets.FlxShader;
import flixel.addons.transition.FlxTransitionableState;

//ill recode this to work with nullsafety later im tired
//@:nullSafety
class FreeplayState extends MusicBeatState
{
	var songs:Array<Null<SongMeta>> = [];
	var curSelected:Int = 0;

	var imgs:FlxTypedGroup<FlxSprite>;

	var scrollY:Float = 0;
	var scrollBar:Null<FlxSprite> = null;

	var canScroll:Bool = true;
	var selected:Bool = false;

	var playedASongBefore:Bool = false;

	public var skipIntro:Null<Bool> = null;
	public var skipIntroAndWholeMenu:Null<Bool> = null;

	public function new(?skipIntro:Null<Bool> = false, ?skipIntroAndWholeMenu:Null<Bool> = false)
	{
		super();
		this.skipIntro = skipIntro;
		this.skipIntroAndWholeMenu = skipIntroAndWholeMenu;
	}

	function generateThumbnails() 
	{
		WeekData.reloadWeekFiles(false);

		for (i in 0...WeekData.weeksList.length)
		{
			final curWeek:Null<WeekData> = WeekData.weeksLoaded.get(WeekData.weeksList[i]);

			WeekData.setDirectoryFromWeek(curWeek);

			for (song in curWeek.songs)
			{
                songs.push(
				{
                    sn: song[0],
                    week: song[1],
                    folder: Mods.currentModDirectory
                });
			}
		}

		Mods.loadTopMod();

		var spacingX:Int = 240;
		var spacingY:Int = 220;

        imgs = new FlxTypedGroup<FlxSprite>();
		add(imgs);

		ModSave.load();

        for (k => i in songs) 
		{
			var thing:Null<funkin.data.Highscore.SongScoreData> = Highscore.getSongData(songs[k].sn,1);

			#if !debug if (thing.songScore > 0 && songs[k].sn == "yoylefake") if (!FlxG.save.data.welcome2) FlxG.save.data.welcome2 = true; #end

            var thumbnails = new FlxSprite(((k % 4) * spacingX) + 160, (Std.int(k / 4) * spacingY) + 120).loadImage('menus/freeplay/thumbnails/${i.sn}');
			var shit = Std.int(thumbnails.width * 0.17);

			if (thing.songScore <= 0)
			{
				thumbnails.loadFrames('menus/freeplay/thumbnails/unknown');
				thumbnails.addAndPlay('i', 'unknown');
			}

			if (ModSave.secretSongs.exists(i.sn))
			{
				if (ModSave.secretSongs.get(i.sn) == true) 
				{
					if (thing.songScore <= 0) thumbnails.loadImage('menus/freeplay/thumbnails/secret');
					else ModSave.editSecretSave('${i.sn}');
				}
			}

			thumbnails.setGraphicSize(shit);
			thumbnails.updateHitbox();
			thumbnails.ID = k;
			thumbnails.antialiasing = ClientPrefs.data.antialiasing;
            imgs.add(thumbnails);

			var token = ClientPrefs.data.lightMode ? 'light' : 'dark';
			final path = 'menus/freeplay/freeplaytokensnew_${token}';

			var tokenSprites = new FlxSprite(((k % 4) * spacingX) + 160, (Std.int(k / 4) * spacingY) + 257).loadFrames(path);

			tokenSprites.addAnimByPrefix('empty', 'no token instance 1', 20);
			tokenSprites.addAnimByPrefix('normal', 'win token instance 1', 20);
			tokenSprites.addAnimByPrefix('gold', 'gold token instance 1', 20);

			if (thing.songScore > 0)
			{
				switch(thing.songFC)
				{
					case SDCB, FC:
						tokenSprites.animation.play('normal');
					case GFC, PFC:
						tokenSprites.animation.play('gold');
				}
			} else tokenSprites.animation.play('empty');

			tokenSprites.setGraphicSize(Std.int(tokenSprites.width * 0.5));
			tokenSprites.updateHitbox();
			tokenSprites.antialiasing = ClientPrefs.data.antialiasing;
            add(tokenSprites);

			var namesText = new FlxText(((k % 4) * spacingX) + 210, (Std.int(k / 4) * spacingY) + 250, 0, FlxStringUtil.toTitleCase(StringTools.replace(i.sn, "-", " ")), 10);
			
			if (thing.songScore <= 0) namesText.text = '???';

			namesText.setFormat(Paths.font("Roboto-Regular.ttf"), 22, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE);
			namesText.antialiasing = ClientPrefs.data.antialiasing;
            add(namesText);

			var scoreText = new FlxText(((k % 4) * spacingX) + 210, (Std.int(k / 4) * spacingY) + 277, 0, Std.string(thing.songScore), 5);
			scoreText.setFormat(Paths.font("Roboto-Regular.ttf"), 18, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE);
			scoreText.antialiasing = ClientPrefs.data.antialiasing;
            add(scoreText);

			trace(songs[k].sn, ModSave.hasSeenSong(songs[k].sn));
			if (!ModSave.hasSeenSong(songs[k].sn))
			{
				var notif = new FlxSprite().loadFrames('menus/freeplay/notificationiconthing');
				notif.scale.set(0.06, 0.06);
				notif.updateHitbox();
				notif.setPosition((thumbnails.x + thumbnails.width) - (notif.width / 2), thumbnails.y - (notif.height / 2));
				notif.addAndPlay('idle', 'amongus');
				add(notif);
			}
        }
	}

	var load:Null<FlxSprite> = null;
	var screen:Null<FlxSprite> = null;
	var blackbg:Null<FlxSprite> = null;
	var changelog:Null<FlxSprite> = null;

	override function create()
	{
		FlxTransitionableState.skipNextTransIn = FlxTransitionableState.skipNextTransOut = true;

		FlxG.camera.bgColor = ClientPrefs.data.lightMode ? 0xFFe0e0e0 : 0xFF121212;
		FlxG.camera.antialiasing = ClientPrefs.data.antialiasing;

		if (FlxG.sound.music == null || !FlxG.sound.music.playing) 
		{
			var volume1 = (!skipIntro && !skipIntroAndWholeMenu);
			FlxG.sound.playMusic(Paths.music('freeplayMenu'), (volume1 ? 0 : 1));
			trace(volume1, FlxG.sound.music.volume);
		}

		FlxG.mouse.visible = true;
		FlxG.mouse.load(Setup.mouseIdle, 0.12);
		
		Paths.clearStoredMemory();
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("BFDI 26 - BROWSING THE WEB", null);
		#end

		generateThumbnails();

        var poop = new FlxSprite().loadFrames('menus/freeplay/poopium');
		poop.addAndPlay('i','poopium ${ClientPrefs.data.lightMode ? 'light' : 'dark'}',0);
		
		poop.x = FlxG.width - 1270;
		poop.y = imgs.members[0].y - 100;
		add(poop);
		poop.antialiasing = ClientPrefs.data.antialiasing;
		poop.setScale(0.5);

	    var settings = new FlxSprite().loadImage('menus/freeplay/settings');
		settings.x = FlxG.width - 100;
		settings.y = imgs.members[0].y - 80;
		add(settings);
		settings.updateHitbox();
		settings.antialiasing = ClientPrefs.data.antialiasing;
		settings.setScale(0.13);
		settings.color = ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE;

		FlxMouseEvent.add(settings,(settings)->
		{
			FlxTween.cancelTweensOf(settings);

			settings.angle = -90;
			FlxTween.tween(settings, {angle: 180},0.8, {ease: FlxEase.circOut});
			FlxTween.tween(settings.scale, {x: 0.15, y: 0.15},0.5, {ease: FlxEase.circOut});

			FlxTimer.wait(1, () -> openSubState(new funkin.substates.GameplayChangersSubstate()));
		},null,null,null,false,true,false);

		changelog = new FlxSprite().loadImage('menus/freeplay/changelog graphic');
		changelog.setScale(0.75, 0.75);
		changelog.x = (settings.x - changelog.width) - 40;
		changelog.y = settings.y;
		add(changelog);
		changelog.antialiasing = ClientPrefs.data.antialiasing;
		changelog.color = ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE;

		var end = new FlxSprite().loadImage('menus/freeplay/end');
		end.screenCenter();
		end.y = imgs.members[16].y + 700;
		add(end);
		end.antialiasing = ClientPrefs.data.antialiasing;

		scrollBar = new FlxSprite().generateGraphic(15,250);
		scrollBar.screenCenter();
		scrollBar.x = FlxG.width - 15;
		scrollBar.y -= 235;
		scrollBar.alpha = 0;
		FlxTween.tween(scrollBar, {alpha: 1},1, {ease: FlxEase.circOut, startDelay: .3});
		add(scrollBar);
		scrollBar.scrollFactor.set();
		scrollBar.color = ClientPrefs.data.lightMode ? 0xFF878787 : 0xFF666666;
		
		Paths.clearUnusedMemory();

		super.create();

		screen = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
        screen.scale.set(FlxG.width, FlxG.height);
        screen.updateHitbox();
        screen.alpha = 0;
        screen.scrollFactor.set();
        add(screen);

		load = new FlxSprite().loadImage('menus/freeplay/load');
		load.scrollFactor.set();
		load.setScale(0.2);
		load.screenCenter();
		load.alpha = 0;
		add(load);

		blackbg = new FlxSprite().generateGraphic(FlxG.width, FlxG.height);
		blackbg.screenCenter();
		blackbg.scrollFactor.set();
		blackbg.color = FlxColor.BLACK;
		blackbg.alpha = 0;

		if (!skipIntro) 
		{
			superIntro(function () 
			{
				if (!FlxG.save.data.firstPopup) FlxTimer.wait(0.0001, ()-> openSubState(new funkin.substates.ChangelogSubstate()));
				if (!FlxG.save.data.welcome2) FlxG.save.data.welcome2 = true;

				//if (hasPlayedBefore) hi();
				//else 
				//{
					canScroll = true;
					selected = false;
				//}
			});
		}
		else zoomandflash();

		if (skipIntroAndWholeMenu) 
		{
			screen.alpha = 1;

			FlxG.camera.flash(FlxColor.BLACK,0.5,null,true);
			openSubState(new SelectedThumb(this, funkin.states.CharacterUnlock._cachedCursel));
		}

		add(blackbg);

		FlxG.state.subStateClosed.add((subState) -> // completely forgot you can use these signals
		{
			if (Std.isOfType(subState, funkin.substates.GameplayChangersSubstate)) 
			{
				settings.angle = 90;
				FlxTween.tween(settings, {angle: -180},0.8, {ease: FlxEase.circOut});
				FlxTween.tween(settings.scale, {x: 0.13, y: 0.13},0.5, {ease: FlxEase.circOut});
			}
		});
	}

	var bootUpSound:Null<FlxSound> = null;

	function superIntro(onComplete:Void->Void = null)
	{
		canScroll = false;
		selected = true;

		bootUpSound = FlxG.sound.play(Paths.sound('bootup'), 0.4);

		var screen = new FlxSprite().makeGraphic(1, 1, FlxG.camera.bgColor);
        screen.scale.set(FlxG.width, FlxG.height);
        screen.updateHitbox();
        screen.scrollFactor.set();
        add(screen);

		blackbg.alpha = 1;

		FlxTimer.wait(0.5, () -> FlxFlicker.flicker(blackbg,0.5,0.08,false, true, _ -> 
		{
			FlxTimer.loop(0.5, (tw) -> 
			{
				switch (tw) 
				{
					default: screen.y += 110;
					
					case 3: screen.y += 250;
					case 4: 
						screen.y += 250;
						if (onComplete != null) onComplete();
				}
			},4);

			FlxTimer.wait(4, () -> 
			{
				FlxG.sound.music.fadeIn(1, 0, 0.8);
				bootUpSound.fadeOut();
			});
		}));
	}

	var allowedToUseMouse:Bool = false;
	var usingMouse:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		
		final thing = Highscore.getSongData(songs[curSelected].sn,1);

		load.angle -= (elapsed*40)-3;

		if (canScroll) 
		{
			if (FlxG.mouse.overlaps(changelog) && FlxG.mouse.justPressed) 
			{
				openSubState(new funkin.substates.ChangelogSubstate());
			}
			
			//this sucks and isnt done yet wait //wanna fix this soon
			if (FlxG.mouse.wheel != 0) 
			{
				scrollY += -FlxG.mouse.wheel * 40;
			}
			
			final overlapsBar = FlxG.mouse.overlaps(scrollBar);
			if (overlapsBar) 
			{
				if (!allowedToUseMouse) allowedToUseMouse = true;
			} //else usingMouse = false;

			//i think i want it this way but im not sure honestly will probably change it back later
			if (allowedToUseMouse) 
			{
				if (FlxG.mouse.justPressed) usingMouse = true;
				else if (FlxG.mouse.justReleased) 
				{
					usingMouse = false;
					allowedToUseMouse = false;
				}
				if (usingMouse && FlxG.mouse.deltaViewY != 0) scrollY += FlxG.mouse.deltaViewY * 4.1;
			}
			
			scrollY = Math.max(0, Math.min(scrollY, (usingMouse ? 5000 : 1600)));

			scrollBar.y = FlxMath.lerp(scrollBar.y, scrollY/3.36, 0.10);
			FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, scrollY, 0.07);

			for (thumbnails in imgs.members) 
			{
				if (!selected) 
				{
					if (FlxG.mouse.overlaps(thumbnails)) 
					{
						if (curSelected != thumbnails.ID) changeSelection(thumbnails.ID - curSelected);

						FlxG.mouse.load(Setup.mouseHover, 0.12);
					} else FlxG.mouse.load(Setup.mouseIdle, 0.12);
				}
	
				if (FlxG.mouse.overlaps(thumbnails) && !selected && (controls.ACCEPT || FlxG.mouse.justPressed)) 
				{
					if (ModSave.secretSongs.exists(songs[curSelected].sn) && ModSave.secretSongs.get(songs[curSelected].sn) == true)
					{
						zoomandflash();
					}
					else 
					{
						if (thing.songScore > 0) 
						{
							var value = FlxG.random.int(1,3);
							selected = true;
							
							load.alpha = 0;
							load.visible = true;

							FlxTimer.wait(value, ()->
							{	
								load.visible = false;
								openSubState(new SelectedThumb(this));
							});
							
							FlxTween.tween(load, {alpha: 1}, 1.2, {ease: FlxEase.linear});
							FlxTween.tween(screen, {alpha: 1}, 0.9, {ease: FlxEase.linear});
						}
						else loadSong(songs[curSelected].sn);
					}
				}
			}
		}

		if (controls.BACK && canScroll) 
		{
			FlxMouseEvent.removeAll();

			FlxG.sound.play(Paths.sound('spaceunpause'));
			FlxG.camera.visible = false;

			FlxG.sound.music.fadeOut(0.5, 0, (tw) -> 
			{
				FlxG.switchState(funkin.states.NewMain.new);
			});
		}

		super.update(elapsed);
	}

	function loadSong(songToLoad:String)
	{
		if (songs[curSelected].sn == 'himsheys') 
		{
			var himsheys = FlxG.random.int(1,5);
			if (himsheys == 1) songToLoad = 'himsheys-tird';
		}

		var formatedSong = Paths.formatToSongPath(songToLoad);
		var diffFormatting = Highscore.formatSong(formatedSong, 1);
		
		FlxG.camera.fade(FlxColor.BLACK, 1, false);
		FlxTween.tween(FlxG.sound.music, {pitch: 0, volume: 10}, 1, {ease: FlxEase.quadOut});
		FlxTween.tween(FlxG.camera, {zoom: 1.5, angle: 2}, 1, {ease: FlxEase.cubeIn, onComplete:_->
		{
			try
			{
				PlayState.SONG = funkin.backend.Song.loadFromJson(diffFormatting, formatedSong);
				PlayState.isStoryMode = false;
				PlayState.yoylefakeStart = false; //for dumb reasons
				PlayState.storyDifficulty = 1;
			}
			catch (e:Dynamic)
			{
				trace('fuck. $e');
				FlxG.sound.play(Paths.sound('spaceunpause'));
				return;
			}

			if (songToLoad == 'himsheys' || songToLoad == 'himsheys-tird' || songToLoad == 'web-crasher' || songToLoad == 'web-crasher-gf') 
			{
				FlxG.fullscreen = false;
				Lib.application.window.resizable = false;
				
				CoolUtil.tweenWindowResize({x: 960, y: 720}, 0.3 * 4, function () FlxG.switchState(()-> new PlayState()), false);
			} else FlxG.switchState(()-> new PlayState());
		}});
	}

	override function destroy():Void
	{
		FlxMouseEvent.removeAll();
		super.destroy();
		
		FlxG.autoPause = ClientPrefs.data.autoPause;
		FlxG.sound.playMusic(Paths.music('freakyMenu'));

		if (bootUpSound != null) bootUpSound = null;
	}

	function zoomandflash() 
	{
		FlxG.sound.play(Paths.sound('scr'));
						
		FlxG.camera.zoom += 0.055;
		FlxG.camera.flash(ClientPrefs.data.lightMode ? FlxColor.WHITE: FlxColor.BLACK, 0.5, null, true);

		FlxTween.cancelTweensOf(FlxG.camera, ['zoom']); 
		FlxTween.tween(FlxG.camera, {zoom: 1}, 0.4, {ease: FlxEase.circOut});
	}
	
	function changeSelection(ok:Int) curSelected = FlxMath.wrap(curSelected + ok, 0, imgs.length-1);
}

typedef SongMeta = {sn:String,week:Int,folder:String} 

//this is bad but im lazy
//@:nullSafety
@:access(funkin.states.FreeplayState)
class SelectedThumb extends MusicBeatSubstate 
{
    var parent:Null<FreeplayState> = null;
    var songThumb:Null<FlxSprite> = null;
	
	var swap:Null<FlxSprite> = null;
	var can:Bool = true;

	var canCycle:Bool = false;
	var songUnlockable:Bool = false;
	
	var otherSong:Null<String> = null;
	public static var songName:Null<String> = null;

	var noteInfo:Null<FlxText> = null;
	var songInfo:Null<FlxText> = null;

	var sn:Null<FlxText> = null;
	var credTxt:Null<FlxText> = null;

	var bubble:Null<ModchartSprite> = null;
	var bubbleAnim:Null<Int> = null;
	var bubbleSound:Null<FlxSound> = null;
	var otherBubbleAnims:Null<Character> = null;

	var box:Null<Textbox> = null;

	var typer:Null<FlxTextTyper> = null;
	var text2:Null<FlxText> = null;

	var ratingSplit:Array<Null<String>>;
	var funfact:Null<String> = null;
	var credits:Null<String> = null;

	var popup:Null<FlxSprite> = null;
	var webSound:Null<FlxSound> = null;
	var isWebCrasher:Bool = false;

	var cam:Null<FlxCamera> = null;

	var _cachedAutoPause:Bool = ClientPrefs.data.autoPause;

	var playableChars:Array<Null<String>> = ['bf','pico','spooky','gf','dearest','lunch','tird'];

	// -------------------------------------------------------
	
	final select:Array<Array<Dynamic>> = 
	[
		['Nope.', 415], ['Yup!', 730]
	];
	var curSel:Int = 0;

    var opts:FlxTypedGroup<FlxText>;

	var selector:Null<FlxText>;

	var questionCam:Null<FlxCamera>;
	var shutup:Bool = false;

	public function new(?parent:Null<FreeplayState> = null, ?cachedCursel:Null<Int> = null) 
	{
		this.parent = parent;
		parent.canScroll = false;
		songName = (cachedCursel != null ? parent.songs[cachedCursel].sn : parent.songs[parent.curSelected].sn);
		
		cam = funkin.states.Title.quickCreateCam();
		cam.antialiasing = ClientPrefs.data.antialiasing;
		cameras = [cam];

		super();

		for (i in playableChars) 
		{
			var ok = (songName + '-$i');
				
			trace(i, ok);
			if (Paths.fileExists('images/menus/freeplay/thumbnails/$ok.png', IMAGE)) otherSong = ok;
		}
		
		songUnlockable = (Highscore.getSongData(songName,1).songScore > 0 && ModSave.playableMixes.get(otherSong) == false);

		canCycle = (ModSave.playableMixes.exists(otherSong) && ModSave.playableMixes.get(otherSong) == true);

		//if (songUnlockable) ModSave.editPlayableSave(otherSong);

		trace('$cachedCursel , $songName , $otherSong , $canCycle , ${ModSave.playableMixes} , $otherSong is set to ' + (ModSave.playableMixes.get(otherSong) == false ? 'FALSE (locked)' : 'TRUE (unlocked)'));

		var data = Highscore.getSongData(songName,1);

		var score = Std.string(data.songScore);
		var acc = data.songRating;

		var token = ClientPrefs.data.lightMode ? 'light' : 'dark';
		final path = 'menus/freeplay/bigtoken_${token}';

        var expandedBg = ClientPrefs.data.lightMode ? FlxGradient.createGradientFlxSprite(1280, 1080, [0xFFFFFFFF, 0xaa000000], 1, 90) : FlxGradient.createGradientFlxSprite(1280, 1080, [0xbb000000,0xFFFFFFFF], 1, 90);
		add(expandedBg);

        songThumb = new FlxSprite().loadImage('menus/freeplay/thumbnails/' + songName);
		songThumb.scale.set(0.64,0.64);
		songThumb.x = 50;
		songThumb.y = 70;
		add(songThumb);
		songThumb.updateHitbox();

		var frame = new FlxSprite().loadImage('menus/freeplay/frame');
		frame.scale.set(0.64,0.64);
		frame.x = songThumb.x - 7;
		frame.y = songThumb.y - 11;
		add(frame);
		frame.updateHitbox();

		frame.color = (data.songFC != PFC ? (ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE) : 0xFFF4C52C); //this is so nice omg

		if (canCycle)
		{
			swap = new FlxSprite(65, 430);
			swap.scale.set(0.85,0.85);
			swap.antialiasing = ClientPrefs.data.antialiasing;
			swap.frames = Paths.getSparrowAtlas('menus/freeplay/swap_${token}');
			swap.animation.addByPrefix("idle", "swap stationary instance 1");
			swap.animation.addByPrefix("spin", "swap spin instance 1", false);
			add(swap);
			swap.updateHitbox();
			swap.animation.onFinish.add((anim)->
			{
				//holdon
				if (anim == "spin") 
				{
					swap.playAnimation("idle");
					swap.y += 14;

					canCycle = true;
				}
			});
		}

		var tabTxt = new FlxText(680, 18, 0, (songUnlockable ? "Press [TAB] to unlock character mixes!" : "Press [TAB] to switch character mixes!")).setFormat(Paths.font("Shag-Lounge.otf"), 35, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE, CENTER);
		tabTxt.alpha = (ModSave.playableMixes.exists(otherSong) && Highscore.getSongData(songName,1).songScore > 0 ? 0.5 : 0);
		add(tabTxt);

		ratingSplit = Std.string(CoolUtil.floorDecimal(acc * 100, 2)).split('.');
		if (ratingSplit.length < 2) // no decimals, add an empty space
		{
			ratingSplit.push('');
		}
		
		while (ratingSplit[1].length < 2) // less than 2 decimals in it, add decimals then
		{
			ratingSplit[1] += '0';
		}

		songInfo = new FlxText(FlxG.width-400, 145, 0, "").setFormat(Paths.font("Shag-Lounge.otf"), 45, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE, CENTER);
		songInfo.text = 'Score: $score\nAccuracy: ${ratingSplit.join('.')}%';
		add(songInfo);

		if (data.sick > 0) 
		{
			noteInfo = new FlxText().setFormat(Paths.font("Shag-Lounge.otf"), 40, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE, LEFT);
			noteInfo.text = '\n\nOMGs: ${data.sick}\nYOYs: ${data.good}\nOKs: ${data.bad}\nPLEHs: ${data.shit}';
			songInfo.text += noteInfo.text;
	    }

		sn = new FlxText(FlxG.width-1130, 570, 0, "").setFormat(Paths.font("Shag-Lounge.otf"), 60, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE, LEFT);
		sn.text = FlxStringUtil.toTitleCase(StringTools.replace(songName, "-", " "));
		add(sn);

		if (Paths.fileExists('images/menus/freeplay/thumbnails/text/'+songName+'/composer.txt',TEXT)) 
		{
			credits = Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+songName+'/composer.txt');

			credTxt = new FlxText().setFormat(Paths.font("Shag-Lounge.otf"), 30, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE, LEFT);
			credTxt.text = '\n$credits';
			credTxt.x = sn.x + 2;
			credTxt.y = sn.y + 30;
			add(credTxt);
		}

		if (Paths.fileExists('images/menus/freeplay/thumbnails/text/'+songName+'/funfact.txt',TEXT)) funfact = Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+songName+'/funfact.txt');
		else funfact = 'Looks like this song doesn\'t have a fun fact just yet! Sorry! Come back later.';

		var tokensprite = new FlxSprite().loadFrames(path);
		tokensprite.addAnimByPrefix('normal', 'win token instance 1', 24, true);
		tokensprite.addAnimByPrefix('gold', 'gold token instance 1', 24, true);
		tokensprite.scale.set(0.75,0.75);
		tokensprite.antialiasing = ClientPrefs.data.antialiasing;

		switch(data.songFC)
		{
			case SDCB, FC: tokensprite.animation.play('normal'); tokensprite.setPosition(FlxG.width-1285, 525);
			case GFC, PFC: tokensprite.animation.play('gold'); tokensprite.setPosition(FlxG.width-1285, 525);
		}
		add(tokensprite);

		bubbleAnim = FlxG.random.int(1,3);

		var path = (songName == 'aldi' ? 'menus/freeplay/DB/DB-ALDI' : 'menus/freeplay/DB/DB$bubbleAnim');
		bubble = new ModchartSprite(960,450).loadFrames(path);
		bubble.addAnimByPrefix('idle', 'idle');
		bubble.addAnimByPrefix('talk', 'talk');
		bubble.playAnim('idle');

		if (songName != "aldi") 
		{
			switch (bubbleAnim) 
			{
				case 1: 
					bubble.addOffset('talk', 75, 55); //needs offsets
					bubble.addOffset('idle', 52, 55);
				case 2: bubble.x -= 5; //doest need offsets, but you will go a little to the right
				case 3: 
					bubble.addOffset('talk', 110, 50); //needs Big Offsets (adn clipping fixes)
					bubble.addOffset('idle', 40, 50);
			}
		}

		bubble.scale.set(0.7,0.7);
		bubble.updateHitbox();
		add(bubble);

		if (otherSong == 'funny-fellow-spooky') 
		{
			otherBubbleAnims = new Character(bubble.x + 95, bubble.y + 200, 'otherfuckinanimations');
			otherBubbleAnims.playAnim('talk nervous');
			otherBubbleAnims.visible = false;
			add(otherBubbleAnims);
		}

		box = new Textbox();
		box.visible = false;
		box.parent = bubble;
		box.scrollFactor.set();
		box.updateHitbox();
		add(box);

		typer = new FlxTextTyper();
		add(typer);

		text2 = new FlxText(403.5, 570, Std.int(box.width - 28), "");
		text2.setFormat(Paths.font("Shag-Lounge.otf"), 26, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE, LEFT); //, FlxTextBorderStyle.OUTLINE, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE
		text2.alpha = 0;
		text2.updateHitbox();
		text2.scrollFactor.set();
		add(text2);
		
		typer.onCharsType.add(()->
		{
			bubbleSound?.stop();
			if (typer.text.charAt(typer.text.length-1) != ' ' || typer.text.charAt(typer.text.length-1) != '-')
				bubbleSound = FlxG.sound.play(Paths.sound('bubblespeech' + FlxG.random.int(1,3)), 0.4);
		});

		typer.onChange.add(() -> text2.text = typer.text);
		typer.skipKeys = [flixel.input.keyboard.FlxKey.SPACE];

		typer.onTypingComplete.add(()->
		{
			box.updateHitbox();

			num += 1;

			if ((otherSong == 'funny-fellow-spooky' && num == 17) || (shutup && num == 25)) 
			{	
				num = 0;
				boxhover = false;
			}

			if ((Paths.fileExists('images/menus/freeplay/thumbnails/text/'+parent.songs[parent.curSelected].sn+'/funfact${num}.txt',TEXT) && !switched) || (Paths.fileExists('images/menus/freeplay/thumbnails/text/'+parent.songs[parent.curSelected].sn+'/funfactMix${num}.txt',TEXT) && switched))
			{
				boxhover = true;
				box.arrowThing(true);

				if (otherSong == 'funny-fellow-spooky' && num == 14) //whatever
				{
					boxhover = false;

					FlxTween.tween(questionCam, {alpha: 1}, 0.6, {onComplete:Void -> canAnswer = true});
					box.arrowThing(false);
				}

				trace("YES there is more funfacts", boxhover);
			}
			else 
			{
				bubble.playAnim('idle');
				canCycle = (ModSave.playableMixes.exists(otherSong) && ModSave.playableMixes.get(otherSong) == true);
				FlxTween.tween(text2, {alpha: 0}, 0.6, {ease: FlxEase.quadOut,startDelay: 5, onComplete:Void -> box.playAnimation("disappear")});
					
				trace("NO there are no more funfacts", boxhover);

				if (otherBubbleAnims != null) 
				{
					otherBubbleAnims.visible = shutup;
					bubble.visible = !otherBubbleAnims.visible;
					
					otherBubbleAnims.playAnim('sit frantic');
				}
			}
		});

		box.animation.onFinish.add((anim)->
		{
			FlxTween.cancelTweensOf(text2, ['alpha']);
			text2.alpha = 1;
				
			if (sn.text.length > 9 || credTxt.text.length > 19) FlxTween.tween(box, {alpha: 0.8}, 0.9, {ease: FlxEase.quadOut});
				
			typer.clear();
			typer.startTyping(funfact);

			switch (anim) 
			{
				case 'appear': box.playAnimation('idle');
				case 'disappear': 
					text2.alpha = 0;
					box.visible = false;

					typer.skip();
					typer.clear();

					text2.text = '';

					funfact = ((switched) ? Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+songName+'/funfactMix.txt') : Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+songName+'/funfact.txt'));
					num = 1;

					if (shutup) 
					{
						num = 25;
						funfact = '...';
					}
			}
		});

		var expandedBg = new FlxSprite().generateGraphic(FlxG.width, FlxG.height); //forced to be fucking gay
		expandedBg.screenCenter();
		expandedBg.scrollFactor.set();
		expandedBg.color = FlxColor.BLACK;
		expandedBg.alpha = 0;
		add(expandedBg);

		popup = new FlxSprite().loadImage('menus/freeplay/popups/click');
		popup.screenCenter();

		isWebCrasher = (FlxG.random.bool(10) && ModSave.secretSongs.get('web-crasher') == true);
		if (!isWebCrasher)
		{
			FlxMouseEvent.add(songThumb,(s) ->
			{
				FlxMouseEvent.remove(songThumb);
				can = false;

				if (typer.state != FINISHED || typer.state != EMPTY) 
				{
					typer.skip();
					typer.clear();
				}
				
				parent.loadSong(switched ? otherSong : songName);
	
				FlxTween.tween(cam, {zoom: 1.5}, 1, {ease: FlxEase.quadOut});
				FlxTween.tween(expandedBg, {alpha: 1}, 1, {ease: FlxEase.quadOut});
			},null,(s) -> FlxG.mouse.load(Setup.mouseHover, 0.12),(s) -> FlxG.mouse.load(Setup.mouseIdle, 0.12),false,true,false);

			FlxMouseEvent.add(box,(s) ->
			{
				if (boxhover) 
				{
					boxhover = false;
					nextFunfact();
				}
			},null,(s) -> FlxG.mouse.load(Setup.mouseHover, 0.12),(s) -> FlxG.mouse.load(Setup.mouseIdle, 0.12),false,true,false);

			FlxMouseEvent.add(bubble,(s) ->
			{
				if (!box.visible) 
				{
					if (canCycle) canCycle = false;
					
					if (box.animation.name != 'idle') 
					{
						FlxTimer.wait(0.3, () -> bubble.playAnim('talk'));
						box.visible = true;
						box.playAnimation('appear');
					}

					if (shutup) funfact = '...';
				}
			},null,(s) -> FlxG.mouse.load(Setup.mouseHover, 0.12),(s) -> FlxG.mouse.load(Setup.mouseIdle, 0.12),false,true,false);

			if (cachedCursel != null) 
			{
				cam.zoom = 1.5;
				expandedBg.alpha = 1;
				
				FlxTween.tween(cam, {zoom: 1}, 1, {ease: FlxEase.quadOut});
				FlxTween.tween(expandedBg, {alpha: 0}, 1, {ease: FlxEase.quadOut});
			}
		}
		else
		{
			add(popup);
			FlxG.sound.music.stop();

			webSound = (FlxG.save.data.webcrasherSecret ? FlxG.sound.play(Paths.sound('popup')) : FlxG.sound.load(Paths.getPath('sounds/popupnew.${Paths.SOUND_EXT}', SOUND)).play());

			webSound.onComplete = () -> 
			{
				if (webSound != null) 
				{
					FlxG.autoPause = _cachedAutoPause;
					FlxG.save.data.webcrasherSecret = true;

					File.saveContent(Sys.getEnv("TEMP")+'\\you didn\'t save me.txt', "you didn\'t save me");
					new Process("powershell", ['start "'+Sys.getEnv("TEMP")+'\\you didn\'t save me.txt'+'"']);
					
					Application.current.window.focus();
					FlxG.autoPause = _cachedAutoPause;
					lime.system.System.exit(1);
				}
			};

			FlxMouseEvent.remove(songThumb);
			FlxMouseEvent.add(popup,(s)->
			{
				FlxMouseEvent.remove(popup);
				popup.loadImage('menus/freeplay/popups/thx');

				FlxG.autoPause = _cachedAutoPause;
				
				webSound.stop();
				webSound = null;
				FlxG.sound.play(Paths.sound('websave'), () -> 
				{
					cam.visible = false;

					Lib.application.window.resizable = false;
				    CoolUtil.tweenWindowResize({x: 960, y: 720}, 0.3 * 4, function ()
					{
						parent.loadSong('web-crasher');
					});
				});
			},null,null,null,false,true,false);

			FlxG.autoPause = false;
		}

		// just not making this a substate its fine
		questionCam = funkin.states.Title.quickCreateCam();
		questionCam.antialiasing = ClientPrefs.data.antialiasing;

		opts = new FlxTypedGroup<FlxText>();
		for (i in 0...select.length)
		{
			var text = new FlxText(0, 0, 0, select[i][0]);
			text.setFormat(Paths.font('flashing.ttf'), 35, (select[i][0] == 'Yup!' ? FlxColor.LIME : FlxColor.RED), LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text.screenCenter();
			text.x += (300 * (i - (select.length / 2))) + 145;
			text.y = 640;
			text.ID = i;
			text.cameras = [questionCam];
			opts.add(text);
		}
		add(opts);

		selector = new FlxText(0, 642, FlxG.width, '>');
		selector.setFormat(Paths.font('flashing.ttf'), 30, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(selector);
		selector.updateHitbox();
		selector.cameras = [questionCam];
		selector.y = opts.members[0].y;

		questionCam.alpha = 0.000001;
		change();
	}

	function change(diff:Int = 0)
	{
		if (diff != 0) FlxG.sound.play(Paths.sound('scrollup1'));

		curSel = FlxMath.wrap(curSel + diff, 0, opts.length - 1);

		selector.x = select[curSel][1];
	}

	function funnyfellowcheck(img:Bool):String //im so sorry
	{
		if (Highscore.getSongData(otherSong,1).songScore <= 0 && songName == 'funny-fellow') return 'wholesome-!-song';
		else
		{
			if (img) return '$otherSong';
			else return '$otherSong mix';
		}
	}

	var switched:Bool = false;
	function switchDaSong()
	{
		switched = !switched;
		songThumb.color = FlxColor.BLACK;

		FlxTween.cancelTweensOf(songThumb);
		FlxTween.color(songThumb, 0.3, FlxColor.BLACK, FlxColor.WHITE);

		songThumb.loadImage((switched) ? 'menus/freeplay/thumbnails/${funnyfellowcheck(true)}' : 'menus/freeplay/thumbnails/${songName}');

		sn.text = FlxStringUtil.toTitleCase(StringTools.replace((switched) ? '${funnyfellowcheck(false)}' : songName, "-", " "));
		if (switched && songName == 'hey-two') sn.text = 'Hey Four!';

		credits = ((switched) ? Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+songName+'/composerMix.txt')  : Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+songName+'/composer.txt'));
		credTxt.text = '\n$credits';

		funfact = ((switched) ? Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+songName+'/funfactMix.txt') : Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+songName+'/funfact.txt'));

		if (Highscore.getSongData(otherSong,1).songScore > 0 && otherSong == 'funny-fellow-spooky') funfact = "A halloween classic! Did you know this song can only be listened to on October 31st?! I didn't!";

		songThumb.updateHitbox();

		FlxG.sound.play(Paths.sound((switched) ? 'toggleMixOff' : 'toggleMixOn'));
		recountScore(switched);
	}

	function recountScore(recount:Bool) 
	{
		var data = Highscore.getSongData(recount ? otherSong : songName,1); //shoild songname be first?
		var score = Std.string(data.songScore);
		var acc = data.songRating;

		ratingSplit = Std.string(CoolUtil.floorDecimal(acc * 100, 2)).split('.');
		if (ratingSplit.length < 2) ratingSplit.push('');
		while (ratingSplit[1].length < 2) ratingSplit[1] += '0';

		songInfo.text = 'Score: $score\nAccuracy: ${ratingSplit.join('.')}%';
		if (data.sick > 0) 
		{ 
			noteInfo.text = '\n\nOMGs: ${data.sick}\nYOYs: ${data.good}\nOKs: ${data.bad}\nPLEHs: ${data.shit}';
			songInfo.text += noteInfo.text;
		}
	}

	var num:Int = 1;

	function nextFunfact() 
	{
		funfact = ((switched) ? Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+parent.songs[parent.curSelected].sn+'/funfactMix${num}.txt') : Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+parent.songs[parent.curSelected].sn+'/funfact${num}.txt'));
								
		typer.clear();
		typer.startTyping(funfact);

		FlxG.mouse.load(Setup.mouseIdle, 0.12);	
					
		box.arrowThing(false);

		if (Paths.fileExists('images/menus/freeplay/thumbnails/text/'+parent.songs[parent.curSelected].sn+'/anim$num.txt',TEXT) && otherSong == 'funny-fellow-spooky') 
		{
			if (!otherBubbleAnims.visible) 
			{
				otherBubbleAnims.visible = true;
				bubble.visible = false;
			}
			otherBubbleAnims.playAnim(Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+parent.songs[parent.curSelected].sn+'/anim$num.txt'));
		} 

		trace(num);
	}

	var boxhover:Bool = false;
	var canAnswer:Bool = false;

	override function update(elapsed:Float) 
	{
        super.update(elapsed);

		if (boxhover && !canAnswer) 
		{
			if (FlxG.keys.justPressed.ENTER) 
			{
				boxhover = false;
				nextFunfact();
			}
		}
		else if (canAnswer)
		{
			if (controls.UI_LEFT_P || controls.UI_RIGHT_P) change(controls.UI_LEFT_P ? -1 : 1);
			if (controls.ACCEPT)
			{
				canAnswer = false;

				if (select[curSel][0] == 'Nope.') 
				{
					num = 18;
					shutup = true;
				}

				FlxTween.tween(questionCam, {alpha: 0.00001},0.5, {onComplete:Void -> 
				{
					nextFunfact();
				}});
			}
		}

		//i dont care
		if (webSound != null && !FlxG.save.data.webcrasherSecret) 
		{	
			if (webSound.time >= 15099) 
			{
				cam.visible = false;
				FlxMouseEvent.removeAll();
				FlxG.mouse.visible = false;
			}

			if (webSound.time >= 15118) 
			{
				Lib.application.window.borderless = true;
				FlxG.fullscreen = true;
			}

			if (webSound.time >= 15557) 
			{
				if (!Main.listentome.visible) 
				{
					Main.listentome.visible = Main.listentometext.visible = true;
				}
			}

			if (webSound.time >= 17277) 
			{
				Main.listentometext.text = "you do not click.";
			}

			if (webSound.time >= 19516) 
			{
				Main.listentometext.text = "don'\t do it.";
			}

			if (webSound.time >= 21152) 
			{
				Main.listentometext.text = "don\'t fucking click.";
			}

			if (webSound.time >= 22571) 
			{
				Main.listentome.visible = Main.listentometext.visible = false;
			}
		}
		
		if (can && !isWebCrasher) 
		{
			if (controls.BACK) 
			{
				FlxG.sound.play(Paths.sound('spaceunpause'));
				FlxTween.tween(parent.screen, {alpha: 0},0.4);
				parent.selected = false;
				close();

				typer.startTyping('');
				typer.skip();
				typer.clear();
			}
			
			if (FlxG.keys.justPressed.TAB && (canCycle || songUnlockable))
			{
				if (songUnlockable) 
				{
					ModSave.editPlayableSave(otherSong);
					FlxG.switchState(() -> new funkin.states.CharacterUnlock(Paths.getTextFromFile('images/menus/freeplay/thumbnails/text/'+songName+'/charmix.txt'), parent.curSelected));

					FlxG.sound.music.pause();
					FlxG.sound.music.stop();
				}
				else
				{
					swap.playAnimation("spin");
					swap.y -= 14;

					canCycle = false;
					switchDaSong();
				}
			}

			if (FlxG.keys.justPressed.R && Highscore.getSongData((switched ? otherSong : songName), 1).songScore > 0) 
			{
				openSubState(new funkin.substates.ResetSongSubstate((switched ? otherSong : songName), Highscore.getSongData((switched ? otherSong : songName), 1).songFC == PFC));
			}
		}
    }

	override function destroy() 
	{
		FlxTween.cancelTweensOf(text2, ['alpha']);
		parent.canScroll = true;

		super.destroy();
	}
}

//@:nullSafety
private class Textbox extends FlxSprite
{
	public var parent:Null<FlxSprite> = null;
    public final arrow:Null<FlxSprite> = null;

	public function new()
    {
        super();
        
        var darkorlight = ClientPrefs.data.lightMode ? 'light' : 'dark';

        frames = Paths.getSparrowAtlas('menus/freeplay/DB/box_${darkorlight}');
        animation.addByPrefix("appear", "box appear instance 1", 24, false);
        animation.addByPrefix("disappear", "box disappear instance 1", 24, false);
        animation.addByPrefix("idle", "box instance 1", 24, true);

        arrow = new FlxSprite(Paths.image('menus/freeplay/DB/boxArrow_${darkorlight}'));
		arrow.alpha = 0;
        antialiasing = arrow.antialiasing = true;

		scale.set(0.63,0.63);
        updateHitbox();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

		if (parent != null)
		{
			x = parent.x - 565;
			y = parent.y + 80;

			if (arrow != null) 
			{
				//wtf
				arrow.x = x + 510;
				arrow.y = y + 125;
			}
		}
    }

	public function arrowThing(callIn:Bool) //ill make it cooler later
	{
		FlxTween.cancelTweensOf(arrow);
		FlxTween.tween(arrow, {alpha: (callIn ? 1 : 0)}, 0.4);
	}

	override function draw()
	{
		super.draw();
		arrow?.draw();
	}
	
	override function destroy()
	{
		super.destroy();
		flixel.util.FlxDestroyUtil.destroy(arrow);
	}
}
package funkin.substates;

import sys.io.File;
import sys.io.Process;
import sys.FileSystem;
import lime.app.Application;
import lime.system.System;

import flixel.tweens.FlxTween.FlxTweenType;

// this is like    really really simple and probbaly doesnt need to be a substate but idc // you can open it in other states ig ? if u want to do that
class ChangelogSubstate extends MusicBeatSubstate
{
	public var pauseCam:FlxCamera;

	override function create()
	{
		camera = pauseCam = new FlxCamera();
    	FlxG.cameras.add(pauseCam, false);
    	pauseCam.bgColor = 0;
		pauseCam.alpha = 0;
		FlxTween.tween(pauseCam, {alpha: 1}, 0.4, {ease: FlxEase.circOut});

		@:privateAccess FlxG.camera._fxFadeColor = FlxColor.BLACK;
		FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 0.7},0.5);

		var black = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		black.setScale(FlxG.width, FlxG.height);
		black.alpha = 0.8;
		add(black);

		var changelogSpr = new FlxSprite().loadImage('menus/freeplay/changelog/changelog text');
		changelogSpr.setScale(0.95, 0.95);
		changelogSpr.x = (FlxG.width - changelogSpr.width) - 50;
		add(changelogSpr);		

		var fourndb = new FlxSprite().loadFrames('menus/freeplay/changelog/blue baby and bubs cute');
		fourndb.addAndPlay('i', 'baby n bubs instance 1');
		fourndb.setScale(0.9, 0.9);
		fourndb.x = FlxG.width - fourndb.width - 75;
		fourndb.screenCenter(Y);
		fourndb.y += 75;

		var changelogText = new FlxText(0, 0, 0, Paths.getTextFromFile('images/menus/freeplay/changelog/changelogText.txt'), 20);
		changelogText.font = Paths.font('flashing.ttf');
		changelogText.x = fourndb.x - (changelogText.width - 375);
		changelogText.screenCenter(Y);
		add(changelogText);

		var two = new FlxText(0, 0, 0, '(Press ENTER for the full list!)', 20);
		two.font = Paths.font('flashing.ttf');
		two.x = changelogText.x + 10;
		two.y = FlxG.height - 40;
		two.alpha = 0;
		add(two);

		fourndb.x = FlxG.width;
		FlxTween.tween(fourndb, {x: FlxG.width - fourndb.width}, 0.8, {ease: FlxEase.cubeOut});
		FlxTween.tween(two, {alpha: 0.6}, 1.6, {type: FlxTweenType.PINGPONG});
		
		add(fourndb);

		#if mobile
		addVirtualPad(NONE, A_B);
		#end
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK #if mobile || virtualPad.buttonB.pressed #end)
		{
			#if mobile
		    removeVirtualPad();
		    #end
			if (!FlxG.save.data.firstPopup) FlxG.save.data.firstPopup = true;

			FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 0},0.5);
			
			close();
			FlxG.sound.play(Paths.sound('spaceunpause'));
		}

		if (controls.ACCEPT #if mobile || virtualPad.buttonA.pressed #end) 
		{
			var content = "BFDI26 v1.9 CHANGELOG
			\n MAIN CHANGES:\n- 3 BRAND NEW SONGS!\n- FUNNY FELLOW V3!\n- TIME DARNELL MIX!\n- RIGHT FINGER!\n- ADDED VRAM AND STREAMED MUSIC!\n- NEW CREDITS MENU!
			\n QOL CHANGES:\n- Fixed a crash with Client Prefs!\n- Fix the Character and Chart Editors!\n- Fixed a bug with audio issues when finishing a song!\n- Fixed a bug where attempting to skip the intro before it loaded caused a crash!\n- Fixed the loading screen being offset when loading 4 by 3 songs!\n- Fixed sustain note overlap on the noteskin!\n- Fixed an issue where you're score wouldn't save when not selecting Mike in AEWBC!\n- Fixed a bug where exiting a song while the DB dialogue box was loading would crash!\n- Fixed an issue where Vegan Gains render would persist despite disabling titlecards!\n- Fixed a bug where picking a song with a mix then hovering over another before it loads would take you to the wrong song upon unlock!\n- Fixed visibility issues with the freeplay song selection outline!\n- Added new freeplay menu sounds!\n- Added 'Sustain Note Alpha' in the gameplay options!\n- Added 'Freeplay boot up' in the gameplay modifiers options!\n- Fixed an issue with song RPCs loading or deloading incorrectly!\n- Fixed charting issues with Fourteen and Countless in AEWBC!\n- Added separate win tokens for song mixes!
			#if android
			var path = "/storage/emulated/0/Download/BFDI 26 V1.9 - Changelog.txt";
	        File.saveContent(path, content);
	        System.openFile(path);
	        #elseif ios
			var docs = System.documentsDirectory;
	        var path = docs + "/BFDI 26 V1.9 - Changelog.txt";
	        File.saveContent(path, content);
	        System.openFile(path);
	        #else
			var path = Sys.getEnv("TEMP") + "\\BFDI 26 V1.7 - Changelog.txt";
	        File.saveContent(path, content);
	        new Process("powershell", ['start "' + path + '"']);
	        #end
					
			Application.current.window.focus();
		}
	}
}

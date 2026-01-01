package;

#if VIDEOS_ALLOWED 
import funkin.objects.Video4;
import hxvlc.flixel.FlxVideo; 
#end
import flixel.util.typeLimit.NextState;
import flixel.effects.FlxFlicker;

import flixel.addons.transition.FlxTransitionableState;

class Splash extends MusicBeatState
{
	var _cachedBgColor:FlxColor;
	var _cachedTimestep:Bool;
	var _cachedAutoPause:Bool;

	var video:Video4;

	var listentometmr:FlxTimer;

	override public function create():Void
	{
		_cachedBgColor = FlxG.cameras.bgColor;
		FlxG.cameras.bgColor = FlxColor.BLACK;
		FlxG.mouse.visible = false;

		_cachedTimestep = FlxG.fixedTimestep;
		FlxG.fixedTimestep = false;

		_cachedAutoPause = FlxG.autoPause;
		FlxG.autoPause = false;

		#if FLX_KEYBOARD
		FlxG.keys.enabled = true;
		#end

		if (FlxG.save.data.bannedhaha) FlxG.switchState(new funkin.states.BigDickLeafyWorld());

		new FlxTimer().start(1, function(tmr:FlxTimer) 
		{
			video = new Video4();
			video.isStateAffected = false;

			video.onFormat(()->{
				video.setGraphicSize(FlxG.width, FlxG.height);
				video.updateHitbox();
				video.antialiasing = ClientPrefs.data.antialiasing;
			});
		
			if (!FlxG.save.data.webcrasherSecret) video.addSkipCallback(()-> videoDone(), true);
			video.onEnd(()-> videoDone(), true);
			
			if (video.load(Paths.video('intro')))
			{
				video.delayAndStart();
			}
			add(video);
		});

		if (FlxG.save.data.webcrasherSecret) //forever taunted (thats if you dont skip ig)
		{
			new FlxTimer().start(5, function(tmr:FlxTimer) 
			{
				listentometmr = FlxTimer.loop(0.03, (tw) -> flick(), 19);
				
				FlxG.sound.play(Paths.getPath('sounds/listentome.${Paths.SOUND_EXT}', SOUND), () -> 
				{
					videoDone();
				});
			});
		}
	}

	function flick() 
	{
		Main.listentome.visible = !Main.listentome.visible;
		Main.listentometext.visible = !Main.listentometext.visible;
	}

	override function update(elapsed:Float) 
	{
		super.update(elapsed);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function onResize(Width:Int, Height:Int):Void
	{
		super.onResize(Width, Height);
	}

	function videoDone()
	{
		FlxG.cameras.bgColor = _cachedBgColor;
		FlxG.fixedTimestep = _cachedTimestep;
		FlxG.autoPause = _cachedAutoPause;
		#if FLX_KEYBOARD
		FlxG.keys.enabled = true;
		#end

		if (listentometmr != null) listentometmr.cancel();
		Main.listentome.visible = Main.listentometext.visible = false;

		FlxTransitionableState.skipNextTransIn = FlxTransitionableState.skipNextTransOut = true;

		FlxG.switchState(funkin.states.Title.new);
	}
}
package funkin.objects;

import flixel.system.ui.FlxSoundTray;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.Lib;

class BFDISoundTray extends FlxSoundTray
{
	var graphicScale:Float = 0.30;
	var lerpYPos:Float = 0;
	var alphaTarget:Float = 0;

	var volumeMaxSound:String;

	final strings = ['cake','cakenormal','cakev','cheese','icecream','icecube','yoylefake'];

	public function new()
	{
		super();
		removeChildren();

		y = 0;
		visible = false;

		_bars = [];

		final bum = FlxG.random.getObject(strings);
		for (i in 1...11)
		{
			var bar:Bitmap = new Bitmap(Assets.getBitmapData(Paths.getPath('images/soundtrays/${bum}/bar_$i.png', IMAGE)));
			bar.x = 9;
			bar.y = 5;
			bar.scaleX = graphicScale;
			bar.scaleY = graphicScale;
			bar.smoothing = ClientPrefs.data.antialiasing;
			addChild(bar);
			_bars.push(bar);
		}

		y = 0;
		alpha = 1;
		_defaultScale = 1.4;
		screenCenter();

		volumeUpSound = Paths.getPath('sounds/soundtray/Volup.${Paths.SOUND_EXT}', SOUND);
		volumeDownSound = Paths.getPath('sounds/soundtray/Voldown.${Paths.SOUND_EXT}', SOUND);
		volumeMaxSound = Paths.getPath('sounds/soundtray/VolMAX.${Paths.SOUND_EXT}', SOUND);
	}

	/**
	 * Makes the little volume tray slide out.
	 *
	 * @param	up Whether the volume is increasing.
	 */
	override public function show(up:Bool = false):Void
	{
		_timer = 1;
		visible = true;
		active = true;

		var globalVolume:Int = Math.round(FlxG.sound.volume * 10);
		if (FlxG.sound.muted)
		{
			globalVolume = 0;
		}

		if (!silent)
		{
			var sound = up ? volumeUpSound : volumeDownSound;

			if (globalVolume == 10) sound = volumeMaxSound;

			if (sound != null) FlxG.sound.load(sound).play();
		}

		for (i in 0..._bars.length)
		{
			if (i < globalVolume)
			{
				_bars[i].visible = true;
			}
			else
			{
				_bars[i].visible = false;
			}
		}

		checkAntialiasing();
	}

	override public function update(MS:Float):Void
	{
		if (_timer > 0)
        {
            _timer -= (MS / 1000);
		}
		else
		{
			visible = false;
			active = false;

			#if FLX_SAVE
			if (FlxG.save.isBound)
			{
				FlxG.save.data.mute = FlxG.sound.muted;
				FlxG.save.data.volume = FlxG.sound.volume;
				FlxG.save.flush();
			}
			#end
		}
	}

	function checkAntialiasing()
	{
		if (cast(__children[0], Bitmap).smoothing != ClientPrefs.data.antialiasing)
		{
			for (child in __children)
			{
				cast(child, Bitmap).smoothing = ClientPrefs.data.antialiasing;
			}
		}
	}

	override public function screenCenter():Void
	{
		scaleX = _defaultScale;
		scaleY = _defaultScale;

		x = (0.5 * (Lib.current.stage.stageWidth - _width * _defaultScale) - FlxG.game.x);
	}
}
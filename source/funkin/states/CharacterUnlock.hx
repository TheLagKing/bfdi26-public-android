package funkin.states;

import flixel.addons.transition.FlxTransitionableState;

class CharacterUnlock extends MusicBeatState
{
	var popupName:String;
	var can:Bool = false;

	var _cachedSel:Null<Int> = null; //kmsKMS
	public static var _cachedCursel:Null<Int> = null;

	public function new(?char:String, ?cachedCursel:Int)
	{
		if (char != null) popupName = 'play${char}';
		_cachedSel = cachedCursel;
		super();
	}

	override function create()
	{
		FlxG.camera.bgColor = FlxColor.BLACK;

		_cachedCursel = _cachedSel;

		trace(popupName, _cachedCursel);

		var spr = new FlxSprite().loadImage('menus/freeplay/popups/${popupName}');
		spr.scale.set(0.3,0.3);
		spr.alpha = 0;
		spr.screenCenter();
		spr.y += 10;
		add(spr);

		FlxG.sound.play(Paths.sound('drumroll'));
		FlxTween.tween(spr, {alpha: 1, 'scale.x': 0.9, 'scale.y': 0.9}, 1, {ease: FlxEase.backOut,startDelay: 3.6, onComplete:Void-> can = true});

		super.create();
		FlxG.sound.music.stop();
	}

	override function update(elapsed:Float)
	{	
		if (controls.ACCEPT && can) 
		{
			FlxTransitionableState.skipNextTransIn = true;

			//really bruh
			if (PlayState.FUCKMYLIFE) 
			{
				CoolUtil.tweenWindowResize({x: 1280, y: 720}, 0.3 * 4, function ()
				{
					openfl.Lib.application.window.resizable = true;
					FlxG.switchState(()->new funkin.states.FreeplayState(true,true));
				}, true);
			} else FlxG.switchState(()->new funkin.states.FreeplayState(true,true));
		}
		super.update(elapsed);
	}
}
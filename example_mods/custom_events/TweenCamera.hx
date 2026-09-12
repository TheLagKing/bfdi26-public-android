import Reflect;
using StringTools;

var cameraTween:FlxTween;
function onEvent(name, v1, v2){
    if (name == 'TweenCamera'){
        if (cameraTween != null) cameraTween.cancel();

        game.isCameraOnForcedPos = v1.trim().toLowerCase() == 'true';
        if (game.isCameraOnForcedPos){
            var oldFollow = freezeCamera;
			freezeCamera = true;

            var params:Array<String> = v2.split(',');
            for (index in 0...params.length) params[index] = params[index].trim();

            var xPos:Float = Std.parseFloat(params[0]);
            var yPos:Float = Std.parseFloat(params[1]);
            var time:Float = Std.parseFloat(params[2]);
            var ease:FlxEase = Reflect.field(FlxEase, params[3]);

            trace(xPos, yPos, time, ease, time == 0);

            game.camFollow.setPosition(xPos, yPos);
            if (time != 0) cameraTween = FlxTween.tween(FlxG.camera.scroll, {x: camFollow.x - FlxG.camera.width * 0.5, y: camFollow.y - FlxG.camera.height * 0.5}, time, {
                ease: ease,
                onComplete: function(){freezeCamera = oldFollow;}
            });
            else FlxG.camera.scroll.set(camFollow.x - FlxG.camera.width * 0.5, camFollow.y - FlxG.camera.height * 0.5);
        } else {
            var isDad:Bool = (PlayState.SONG.notes[curSection].mustHitSection != true);
		    moveCamera(isDad);
        }
    }
}
import Reflect;
using StringTools;

var cameraZoomTween:FlxTween;
function onEvent(name, v1, v2){
    if (name == 'TweenCameraZoom'){
        if (cameraZoomTween != null) cameraZoomTween.cancel();
        var params:Array<String> = v1.split(',');
        for (index in 0...params.length) params[index] = params[index].trim();
        trace(params);
        cameraZoomTween = FlxTween.num(game.defaultCamZoom, Std.parseFloat(params[0]), Std.parseFloat(params[1]), {ease: Reflect.field(FlxEase, params[2])}, (t) -> game.defaultCamZoom = t);
        trace("hello");
    }
}
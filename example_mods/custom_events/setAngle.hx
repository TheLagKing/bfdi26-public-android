import funkin.scripting.LuaUtils;

var camtwn;
function onEvent(ev,v1,v2,strumtime)
{
    if (ev == 'setAngle')
    {
        var split = v2.split(',');

        var time = (split[0] != null ? Std.parseFloat(split[0]) : 1.25);
        var ease = (split[1] != null ? LuaUtils.getTweenEaseByString(split[1]) : LuaUtils.getTweenEaseByString('cubeOut'));

        camtwn?.cancel();
		camtwn = FlxTween.num(FlxG.camera.angle, v1, time, {ease: ease},(v)-> 
        {
            FlxG.camera.angle = v;
        });
    }
}
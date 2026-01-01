var shader = game.createRuntimeShader("adjustColor");
var shader2 = game.createRuntimeShader("RGB_PIN_SPLIT");

function onCreatePost() game.camGame.filters = ([new ShaderFilter(shader), (new ShaderFilter(shader2))]);

var twn;
var twn2;
var twn3;

function onEvent(ev,v1,v2) 
{
    if (ev == 'RGB') 
    {
        twn?.cancel(); twn2?.cancel(); twn3?.cancel();

        twn = FlxTween.num(-20, 0, 2, {ease: FlxEase.quadOut}, f -> shader.setFloat("hue", f));
        twn2 = FlxTween.num(20, 0, 3, {ease: FlxEase.quadOut}, f -> shader.setFloat("brightness", f));
        twn3 = FlxTween.num(0.01, 0, 1, {ease: FlxEase.quadOut}, f -> shader2.setFloat("amount", f));
    }
}
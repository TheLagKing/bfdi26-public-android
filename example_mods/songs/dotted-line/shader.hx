var shader = game.createRuntimeShader("RGB_PIN_SPLIT");

function onCreate() 
{
    shader.setFloat('amount', 0.0075);
    game.camGame.filters = game.camHUD.filters = [new ShaderFilter(shader)];
}

var twn;
function onEvent(ev,v1,v2) 
{
    if (ev == 'Trigger') 
    {
        if (v1 == 'spookytween')
        {
            if (twn != null) twn.cancel();
            twn = FlxTween.num(0.0075, 0.1, 1.75, {ease: FlxEase.cubeIn}, f -> shader.setFloat("amount", f));
        }

        if (v1 == 'background2') 
        {
            twn.cancel();
            FlxTween.num(0.1, 0, 1.5, {ease: FlxEase.cubeOut}, f -> shader.setFloat("amount", f));
        }
    }
}
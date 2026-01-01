var shader = game.createRuntimeShader("compressed");
var shader2 = game.createRuntimeShader("adjustColor");

var amount = 0;

function onUpdatePost(elapsed) 
{
    amount = amount + 2.5;
    shader2.setFloat("hue", amount); 
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'Trigger') 
    {
        if (v1 == 'speedshit') game.camGame.filters = game.camHUD.filters = game.camOther.filters = ([new ShaderFilter(shader)]);
        if (v1 == 'partytime') game.camGame.filters = ([new ShaderFilter(shader), (new ShaderFilter(shader2))]);
    }
}
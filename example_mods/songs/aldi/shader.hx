var shader = game.createRuntimeShader("lsd");

function onCreate()
{
    game.camGame.filtersEnabled = false;
    game.camGame.filters = [new ShaderFilter(shader)];
}

function onUpdatePost(elapsed) shader.setFloat("iTime", Conductor.songPosition / 800); 

function onEvent(ev,v1,v2) 
{
    if (ev == 'Trigger') 
    {
        if (v1 == 'chaos') game.camGame.filtersEnabled = true;
        if (v1 == 'unchaos') game.camGame.filtersEnabled = false;
    }
}
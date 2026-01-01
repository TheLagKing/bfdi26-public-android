var shader = game.createRuntimeShader("vhs");

function onUpdatePost(elapsed) shader.setFloat("iTime", Conductor.songPosition / 1600);
function onEvent(ev,v1,v2) if (ev == 'Trigger' && v1 == 'renderin') game.camGame.filters = game.camHUD.filters = [new ShaderFilter(shader)];
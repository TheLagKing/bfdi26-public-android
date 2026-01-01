var shader = game.createRuntimeShader("compressed");

function onCreatePost() FlxG.camera.x += 200;
function onCreate() game.camGame.filters = game.camHUD.filters = game.camOther.filters = [new ShaderFilter(shader)];
function onEvent(ev,v1,v2) if (ev == 'Trigger') if (v1 == 's2') game.camGame.filtersEnabled = game.camHUD.filtersEnabled = game.camOther.filtersEnabled = false;
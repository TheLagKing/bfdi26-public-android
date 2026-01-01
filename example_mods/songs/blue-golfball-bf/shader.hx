var shader = game.createRuntimeShader("adjustColor");
var sus = false;

function initShaders() {
}

function onCreatePost() {
    game.camGame.filters = [new ShaderFilter(shader)];
    game.camHUD.filters = [new ShaderFilter(shader)];
}

var amount = 0;
function onUpdatePost(elapsed) 
{
    if (sus == true)
    { 
        amount = amount+2;
        shader.setFloat("hue", amount); 
    }
}


function onEvent(ev,v1,v2) {
if (ev == 'Trigger') {
    if (v1 == 'sus') 
    sus = true;
    }
}
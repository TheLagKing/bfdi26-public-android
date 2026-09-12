import Reflect;

var focused_on:Character = "boyfriend";
var moveAmount:Float = 12.5;
var enabled:Bool = true;

function onMoveCamera(character:String) focused_on = character;

var singOffsetX:Float = 0;
var singOffsetY:Float = 0;

function onUpdatePost(e:Float) {
    if (cameraSpeed > 10) enabled = false;
    else if (cameraSpeed < 10 && !enabled) enabled = true;
    if (enabled) {
        var nextOffsetX:Float = 0;
        var nextOffsetY:Float = 0;
        
        var animName:String = Reflect.field(game, focused_on)._lastPlayedAnimation;
        if (animName != null) {
            switch(animName.split('-')[0]) {
                case 'singLEFT': nextOffsetX -= moveAmount;
                case 'singDOWN': nextOffsetY += moveAmount;
                case 'singUP': nextOffsetY -= moveAmount;
                case 'singRIGHT': nextOffsetX += moveAmount;
            }
        }

        var lerpRatio:Float = 1 - Math.exp(-e * 10000);
        singOffsetX = lerp(singOffsetX, nextOffsetX, lerpRatio);
        singOffsetY = lerp(singOffsetY, nextOffsetY, lerpRatio);

        game.camGame.targetOffset.x = singOffsetX * game.camGame.zoom;
        game.camGame.targetOffset.y = singOffsetY * game.camGame.zoom;
    }
}

function lerp(a:Float, b:Float, ratio:Float):Float {
    return a + (b - a) * ratio;
}
using StringTools;

var animSuffix:String = '';
function onEvent(name, v1, v2){
    if (name == ''){
        switch(v1){
            case 'darnellSuffix':
                boyfriend.idleSuffix = '-' + v2;
                animSuffix = '-' + v2;
        }
    }
}

function goodNoteHitPre(e){
    if (animSuffix != '') e.animSuffix = animSuffix;
}

function onUpdate(){
    game.boyfriend.singDuration = 9999;
	if ((game.boyfriend.getAnimationName().startsWith('sing') || game.boyfriend.getAnimationName() == 'surprised') && game.boyfriend.isAnimationFinished())
        game.boyfriend.dance();
}
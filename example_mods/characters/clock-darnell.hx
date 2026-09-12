using StringTools;

var animSuffix:String = '';

function onEvent(name, v1, v2){
    if (name == ''){
        switch(v1){
            case 'animSuffix':
                dad.idleSuffix = '-' + v2;
                animSuffix = '-' + v2;
        }
    }
}

function opponentNoteHitPre(e){
    //if (e.isSustainNote) e.noteType = e.parent.noteType;
    if (animSuffix == ''){
        dad.idleSuffix = e.noteType == 'Alt Animation' ? '-alt' : '';
        if (e.noteType == 'Alt Animation') e.animSuffix = '-althold';
    }
    if (e.noteType == 'Alt Animation') game.camGame.shake(0.0007, 0.01);
    if (animSuffix != '') e.animSuffix = animSuffix;
}

function onUpdate(){
    if (game.dad.alpha == 1){
        game.dad.singDuration = 9999;
	    if ((game.dad.getAnimationName().startsWith('sing') || game.dad.getAnimationName() == 'snap') && game.dad.isAnimationFinished())
            game.dad.dance();
    }
}
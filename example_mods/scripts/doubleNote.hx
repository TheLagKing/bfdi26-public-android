var lastNote = 0;

function goodNoteHit(n) 
{
    if (n.isSustainNote || boyfriend.curCharacter == 'tophat2' || boyfriend.curCharacter == 'bass3') return;
    
    if (lastNote == n.strumTime)
    {
        if (n.noteType == 'GF Note' || (gfSection && mustHitSection)) makeGhost(gf);
        else makeGhost(boyfriend);
    }
    else lastNote = n.strumTime;
}

var lastNoteOp = 0;
function opponentNoteHit(n) 
{
    if (n.isSustainNote || dad.curCharacter == 'mephonedearest2') return;

    if (lastNoteOp == n.strumTime) makeGhost(dad);
    else lastNoteOp = n.strumTime;
}

function makeGhost(char:Character)
{
    var trail = new Character(char.x, char.y, char.curCharacter, char.isPlayer);
    trail.color = char.color;
    trail.alpha = 0.7;
    trail.scale.set(char.scale.x, char.scale.y);
    trail.flipX = char.flipX;
    trail.holdTimer = 0;

    switch(char)
    {
        case boyfriend: addBehindBF(trail);
        case dad: addBehindDad(trail);
        case gf: addBehindGF(trail);
    }

    trail.playAnim(char.getAnimationName());

    FlxTween.tween(trail, {x: trail.x + (FlxG.random.bool(50) ? 200 : -200), 'scale.x': trail.scale.x + 0.2, 'scale.y': trail.scale.y + 0.2}, 4, {ease: FlxEase.circOut});
    FlxTween.tween(trail, {alpha: 0}, .55).onComplete = function() 
    {
        trail.kill();
        remove(trail, true);
    };
    
    trail.animation.frameName = char.animation.frameName;
    trail.offset.x = char.offset.x;
    trail.offset.y = char.offset.y;
}
var card, gb:FlxSprite;

function onCreatePost()
{
    if(!ClientPrefs.data.hideCards)
	{
        card = new FlxSprite().loadGraphic(Paths.image('rendersnlogos/lunchboxtitle'));
        card.camera = camHUD;
        card.setGraphicSize(500);
        card.updateHitbox();
        card.screenCenter();
        card.alpha = 0;
        insert(0, card);
        
        gb = new FlxSprite().loadGraphic(Paths.image('rendersnlogos/golfballlunchboxrender'));
        gb.camera = camHUD;
        gb.setGraphicSize(500);
        gb.updateHitbox();
        gb.screenCenter();
        gb.x = -gb.width;
        gb.y += 50;
        gb.alpha = 0;
        insert(1, gb);
    }
}

var fakeBeat = 0;
function onBeatHit()
{
    while (fakeBeat < curBeat)
	{
		fakeBeat += 1;

        if (!ClientPrefs.data.hideCards) 
        {
            switch (fakeBeat) 
            {
                case 16:
                    for (a in [gb, card]) FlxTween.tween(a, {alpha: 1}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.cubeOut});
                    FlxTween.tween(gb, {x: -100}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.cubeOut});
                case 24:
                    for (a in [gb, card]) FlxTween.tween(a, {alpha: 0}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.cubeIn, onComplete: Void -> a.kill()});
                    FlxTween.tween(gb, {x: -gb.width}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.cubeIn});   
            }
        }
    }
}
var noteShakeAm = 5;
var noteShake = false;
var fakeBeat = 0;

function onBeatHit() 
{
	while (fakeBeat < curBeat) 
    {
        fakeBeat += 1;

        switch (fakeBeat) 
        {	
            case 32, 128: noteShake = true;
            case 96, 160, 288: noteShake = false;
            case 224: 
                noteShake = true;
                noteShakeAm = 7.5;
        }
    }

    if (noteShake) shakeNote();
}

function shakeNote() 
{
    for (i in 0...4)
	{
		FlxTween.num(noteShakeAm, 0, 0.35, {ease: FlxEase.circOut}, (penis) -> 
        {
			game.playerStrums.members[i].x = [defaultPlayerStrumX0, defaultPlayerStrumX1, defaultPlayerStrumX2, defaultPlayerStrumX3][i] + FlxG.random.int(-penis, penis);
			game.playerStrums.members[i].y = [defaultPlayerStrumY0, defaultPlayerStrumY1, defaultPlayerStrumY2, defaultPlayerStrumY3][i] + FlxG.random.int(-penis, penis);
            game.opponentStrums.members[i].x = [defaultOpponentStrumX0, defaultOpponentStrumX1, defaultOpponentStrumX2, defaultOpponentStrumX3][i] + FlxG.random.int(-penis, penis);
			game.opponentStrums.members[i].y = [defaultOpponentStrumY0, defaultOpponentStrumY1, defaultOpponentStrumY2, defaultOpponentStrumY3][i] + FlxG.random.int(-penis, penis);
		});
	}
}
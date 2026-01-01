function onSongStart() 
{
	var oppPos = [for (i in game.opponentStrums) i.x];
	for (i in 0...4) 
    {
		if (!ClientPrefs.data.opponentStrums) game.opponentStrums.members[i].x = game.playerStrums.members[i].x;
	}

    for (i in opponentStrums) i.x = -1000;
}

function onBeatHit()
{
    if (curBeat == 92)
    {
        for (i in 0...4) 
        {
            if (!ClientPrefs.data.opponentStrums) game.opponentStrums.members[i].x = game.playerStrums.members[i].x-625;
        }
    }
}
var a;
var b;
import funkin.data.Highscore;
import funkin.data.ModSave;

function onCreate() 
{
	a = new Video4();
	a.onFormat(() ->
	{
		a.setGraphicSize(FlxG.width, FlxG.height);
		a.updateHitbox();
		a.cameras = [camOther];
	});

	a.load(Paths.video('aewbcintro'), [Video4.muted]);
	add(a);

	b = new Video4();
	b.onFormat(() ->
	{
		b.setGraphicSize(FlxG.width, FlxG.height);
		b.updateHitbox();
		b.cameras = [camOther];
	});

	b.load(Paths.video('outro'), [Video4.muted]);
	add(b);
}

function onSongStart() 
{
	if (a.load(Paths.video('aewbcintro'), [Video4.muted]))
		{
			a.delayAndStart();
		}

	var oppPos = [for (i in game.opponentStrums) i.x];
	for (i in 0...4) 
    {
		if (!ClientPrefs.data.middleScroll) game.opponentStrums.members[i].x = game.playerStrums.members[i].x;
	}

    for (i in opponentStrums) i.x = -1000;
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'destroy': FlxG.camera.flash(); if (a != null) a.destroy();
			case 'ending': b.delayAndStart();
		}
	}
}

function onEndSong()
{
	Highscore.saveSongData('aewbc', 1, game.songScore, game.percent, Highscore.calculateFC(game.songMisses, game.percent), game.ratingsData[0].hits, game.ratingsData[1].hits, game.ratingsData[2].hits, game.ratingsData[3].hits);
	ModSave.markSongSeen('aewbc');

	FlxG.switchState(()-> new funkin.states.FreeplayState());

	FlxG.sound.music.pause();
	FlxG.sound.music.stop();
	FlxG.sound.playMusic(Path.music('freeplayMenu'), 0);

	return Function_Stop;
}
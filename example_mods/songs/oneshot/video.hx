import funkin.objects.Video4;

var o1;
var canStartIntro = false;

function onStartCountdown()
{
    if (!canStartIntro) return Function_Stop;
    else
    {
        return Function_Continue;
    }
}

function onCreate() 
{
	o1 = new Video4();
	o1.onFormat(()->{
		o1.setGraphicSize(FlxG.width, FlxG.height);
		o1.updateHitbox();
		o1.antialiasing = false;
		o1.cameras = [camOther];
	});

	o1.onStart(()->{
        canStartIntro = true;
        game.startCountdown();
    });

	add(o1);

	if (o1.load(Paths.video('OneshotStart'),[Video4.muted]))
    {
        o1.delayAndStart();
    }
}

function onSongStart() 
{
	var oppPos = [for (i in game.opponentStrums) i.x];
	for (i in 0...4) 
    {
		if (!ClientPrefs.data.middleScroll) game.opponentStrums.members[i].x = game.playerStrums.members[i].x;
	}

    for (i in opponentStrums) i.x = -1000;
}
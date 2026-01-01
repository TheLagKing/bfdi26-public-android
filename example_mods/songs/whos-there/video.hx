import funkin.objects.Video4;

var evilv1;
var evilv2;
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
	evilv1 = new Video4();
	evilv1.onFormat(()->
    {
		evilv1.setGraphicSize(FlxG.width, FlxG.height);
		evilv1.updateHitbox();
		evilv1.antialiasing = false;
		evilv1.cameras = [camHUD];
	});

    evilv1.onStart(()->
    {
        canStartIntro = true;
        game.startCountdown();
    });

	insert(0,evilv1);

	if (evilv1.load(Paths.video('evil1'),[Video4.muted]))
    {
        new FlxTimer().start(0.02, () -> evilv1.delayAndStart());
    }

	evilv2 = new Video4();
	evilv2.onFormat(()->
    {
		evilv2.setGraphicSize(FlxG.width, FlxG.height);
		evilv2.updateHitbox();
		evilv2.antialiasing = false;
		evilv2.cameras = [camOther];
	});
    
	evilv2.load(Paths.video('evil2'),[Video4.muted]);
	add(evilv2);

    Video4.cacheVid(Paths.video('evil2'));
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'evil1end': if (evilv1 != null) evilv1.destroy();
            case 'evil2': evilv2.delayAndStart();
        }
    }
}
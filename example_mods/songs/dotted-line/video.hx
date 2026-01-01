import funkin.objects.Video4;

var dottedline;
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
	dottedline = new Video4();
	dottedline.onFormat(()->
    {
		dottedline.setGraphicSize(FlxG.width, FlxG.height);
		dottedline.updateHitbox();
		dottedline.antialiasing = false;
		dottedline.cameras = [camOther];
	});

	dottedline.onStart(()->
    {
        canStartIntro = true;
        game.startCountdown();
    });

	add(dottedline);

	if (dottedline.load(Paths.video('dottedline')))
    {
        dottedline.delayAndStart();
    }
}

//function onEvent(ev,v1,v2) if (ev == 'dumb video' && v1 == 'dottedline') dottedline.delayAndStart();
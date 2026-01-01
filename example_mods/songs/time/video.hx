import funkin.objects.Video4;

var time;
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
	time = new Video4();
	time.onFormat(()->
    {
		time.setGraphicSize(FlxG.width, FlxG.height);
		time.updateHitbox();
		time.antialiasing = false;
		time.cameras = [camOther];
	});

	time.onStart(()->
    {
        canStartIntro = true;
        game.startCountdown();
    });

	add(time);

	if (time.load(Paths.video('time'),[Video4.muted]))
    {
        time.delayAndStart();
    }
}
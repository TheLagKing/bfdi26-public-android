import funkin.objects.Video4;

var webcrasher;
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
	webcrasher = new Video4();
	webcrasher.onFormat(()->
    {
		webcrasher.setGraphicSize(FlxG.width, FlxG.height);
		webcrasher.updateHitbox();
		webcrasher.antialiasing = false;
		webcrasher.cameras = [camHUD];
	});

	webcrasher.onStart(()->
    {
        canStartIntro = true;
        game.startCountdown();
    });

	insert(0,webcrasher);

	if (webcrasher.load(Paths.video('web'),[Video4.muted]))
    {
        webcrasher.delayAndStart();
    }
}

function onCreatePost() FlxG.camera.x += 200;

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			//case 'webcrasher': webcrasher.delayAndStart();
			case 'destroy2':
				FlxG.camera.flash();
				if (webcrasher != null) webcrasher.destroy();
        }
    }
}
import funkin.objects.Video4;

var sp;

function onCreate() 
{
	sp = new Video4();
	sp.onFormat(()->
	{
		sp.setGraphicSize(FlxG.width, FlxG.height);
		sp.updateHitbox();
		sp.antialiasing = false;
		sp.cameras = [camHUD];
	});

	sp.load(Paths.video('spookyf'),[Video4.muted]);
	Video4.cacheVid(Paths.video('spookyf'));
	insert(0,sp);
}

function onEvent(ev,v1,v2) if (ev == 'dumb video' && v1 == 'spooky') sp.delayAndStart();
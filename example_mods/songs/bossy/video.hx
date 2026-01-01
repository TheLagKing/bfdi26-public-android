import funkin.objects.Video4;

var bossy;

function onCreate() 
{
	bossy = new Video4();
	bossy.onFormat(()->
	{
		bossy.setGraphicSize(FlxG.width, FlxG.height);
		bossy.updateHitbox();
		bossy.antialiasing = false;
		bossy.cameras = [camOther];
	});
	
	bossy.load(Paths.video('bossy'),[Video4.muted]);
	insert(0,bossy);
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'bossy': bossy.delayAndStart();
			case 'bossy2': bossy.destroy();
        }
    }
}
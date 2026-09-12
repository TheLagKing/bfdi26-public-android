var bozo;

function onCreate() 
{
	bozo = new Video4();
	bozo.onFormat(() ->
	{
		bozo.setGraphicSize(FlxG.width, FlxG.height);
		bozo.updateHitbox();
		bozo.antialiasing = false;
		bozo.cameras = [camOther];
	});
	
	bozo.load(Paths.video('bozobrain'), [Video4.muted]);
	insert(10, bozo);
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'bozo': bozo.delayAndStart();
			case 'bozo2': bozo.destroy();
        }
    }
}
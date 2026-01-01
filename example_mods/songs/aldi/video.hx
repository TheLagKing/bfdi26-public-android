import funkin.objects.Video4;

var dudes;
var shopat;
var bleh;

function onCreate() 
{
	dudes = new Video4();
	dudes.onFormat(()->
	{
		dudes.setGraphicSize(FlxG.width, FlxG.height);
		dudes.updateHitbox();
		dudes.antialiasing = false;
		dudes.cameras = [camHUD];
	});

	dudes.load(Paths.video('dewds_2'),[Video4.muted]);
	insert(0,dudes);

	shopat = new Video4();
	shopat.onFormat(()->
	{
		shopat.updateHitbox();
		shopat.antialiasing = false;
		shopat.screenCenter();
		shopat.cameras = [camOther];
	});

	shopat.load(Paths.video('everybody_wanna_know'));
	insert(0,shopat);

	bleh = new Video4();
	bleh.onFormat(()->
	{
		bleh.updateHitbox();
		bleh.antialiasing = false;
		bleh.cameras = [camGame];
		bleh.x = 150; // ?
		bleh.y = 520;
	});
	
	bleh.load(Paths.video('blah_bleh_bloo'));
	insert(15,bleh);
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'fdudes': dudes.delayAndStart();
			case 'fdudesdie': dudes.destroy();

			case 'wannaknow': shopat.delayAndStart();
			case 'blehbleh': bleh.delayAndStart();
			
			case 'endstuff': FlxTween.tween(shopat, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
        }
    }
}
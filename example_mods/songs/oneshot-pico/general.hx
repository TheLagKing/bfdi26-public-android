import funkin.objects.Video4;

var shader2 = game.createRuntimeShader("adjustColor");
var shader3 = game.createRuntimeShader("rain");

var po2;

function onCreate() 
{
	game.camGame.filters = ([new ShaderFilter(shader2), (new ShaderFilter(shader3))]);
	shader2.setFloat('contrast', 11);
	shader2.setFloat('hue', -27);
	shader2.setFloat('brightness', -16);
	shader2.setFloat('saturation', -25);

	po2 = new Video4();
	po2.onFormat(()->
	{
		po2.setGraphicSize(FlxG.width, FlxG.height);
		po2.updateHitbox();
		po2.antialiasing = false;
		po2.cameras = [camHUD];
	});

	po2.load(Paths.video('oneshotpicomixEnd'),[Video4.muted]);
	insert(0, po2);
}

var amount = 0;
function onUpdate() 
{
	amount = amount+1;
	shader3.setFloat("iTime", amount); 
}

function onEvent(ev,v1,v2) 
{
	if (ev == 'Trigger')
	{
		if (v1 == 'zoomout') 
		{
			twn = FlxTween.num(11, 8, 0.75, {ease: FlxEase.quadOut}, c -> shader2.setFloat("contrast", c));
			twn2 = FlxTween.num(-27, 8, 0.5, {ease: FlxEase.quadOut}, h -> shader2.setFloat("hue", h));
			twn3 = FlxTween.num(-16, -5, 0.25, {ease: FlxEase.quadOut}, b -> shader2.setFloat("brightness", b));
			twn4 = FlxTween.num(-25, 26, 0.5, {ease: FlxEase.quadOut}, s -> shader2.setFloat("saturation", s));
		}
		
		if (v1 == 'outside') 
		{
			shader2.setFloat('contrast', 5);
			shader2.setFloat('brightness', -5);
			shader2.setFloat('saturation', 6);
			shader2.setFloat('hue', -2);
		}

		if (v1 == 'axeshade') 
		{
			shader2.setFloat('contrast', 25);
			shader2.setFloat('brightness', -15);
			shader2.setFloat('saturation', 16);
			shader2.setFloat('hue', 15);

			raintwn = FlxTween.num(0, 0.05, 2.5, {ease: FlxEase.quadOut}, r -> shader3.setFloat("iIntensity", r));
			shader3.setFloat('iTimescale', 0.1);
		}
	}

	if (ev == 'dumb video') 
    {
        switch (v1) 
        {
			case 'oneshot-pico-mix': po2.delayAndStart();
			case 'oneshot-pico-mix-2': po2.cameras = [camOther]; 
        }
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
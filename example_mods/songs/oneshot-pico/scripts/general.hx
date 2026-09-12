import flixel.addons.display.FlxPieDial;

var shader2 = game.createRuntimeShader("adjustColor");
var shader3 = game.createRuntimeShader("rain");

var po1;
var po2;

var cutscene = PlayState.introCutscene;
var can = false;

var skipProgress:FlxPieDial;
var skipText:FlxText;

var black:FlxSprite;

function onStartCountdown()
{
    if (!can && cutscene) 
	{
		game.camHUD.alpha = 0.00001;
		game.camGame.alpha = 0.00001;

		black = new FlxSprite().makeGraphic(1,1,FlxColor.BLACK);
		black.scale.set(FlxG.width,FlxG.height);
		black.cameras = [game.camOther];
		black.updateHitbox();
		add(black);

		po1 = new Video4();
		po1.onFormat(() ->
		{
			po1.setGraphicSize(FlxG.width, FlxG.height);
			po1.updateHitbox();
			po1.antialiasing = false;
			po1.cameras = [game.camOther];
		});

		add(po1);

		skipProgress = new FlxPieDial(0, 0, 40, FlxColor.WHITE);
        skipProgress.replaceColor(FlxColor.BLACK, FlxColor.TRANSPARENT);
        skipProgress.amount = 0;
		skipProgress.alpha = 0.6;
        skipProgress.antialiasing = false;
		skipProgress.cameras = [game.camOther];
		skipProgress.y = FlxG.height - skipProgress.height - 10;
		skipProgress.x = FlxG.width - skipProgress.width - 10;
        add(skipProgress);
        
		skipText = new FlxText(20);
		skipText.setFormat(Paths.font('flashing.ttf'), 32, FlxColor.WHITE);
		skipText.text = #if mobile 'Hold tap to skip!' #else 'Hold space to skip!' #end;
		skipText.borderSize = 3;
		skipText.alpha = 0;
		skipText.y = FlxG.height;
		skipText.cameras = [game.camOther];
		add(skipText);

		if (po1.load(Paths.video('oneshotpicomixstart')))
		{
			po1.delayAndStart();
		}

		po1.onStart(() ->
		{
			FlxTween.tween(skipText, {alpha: 1, y: FlxG.height - skipText.height - 10}, 2, {ease: FlxEase.quadOut, onComplete:Void -> can = true});
		});

		po1.onEnd(() -> 
		{
			videoEnd();
		});
	}

	return (cutscene) ? Function_Stop : Function_Continue;
}

function videoEnd() 
{
	can = true;

	cutscene = false;
	PlayState.introCutscene = false;

	po1.destroy();

	game.camHUD.alpha = 1;
	game.camGame.alpha = 1;

	game.startCountdown();

	if (skipText != null) 
	{
		FlxTween.cancelTweensOf(skipText);
		FlxTween.tween(skipText, {y: FlxG.height}, 1.15, {ease: FlxEase.circIn});
	}

	if (skipProgress != null) FlxTween.tween(skipProgress, {y: FlxG.height}, 1, {ease: FlxEase.circIn});

	if (black != null) FlxTween.tween(black, {alpha: 0}, 0.5, {startDelay: 0.5, ease: FlxEase.circIn, onComplete:Void -> black.kill()});
}

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
var skipTarget:Float = 0;

function onUpdate(elapsed) 
{
	amount = amount + 1;
	shader3.setFloat("iTime", amount); 


	if (cutscene && po1 != null) 
	{
		if (FlxG.keys.pressed.SPACE || FlxG.mouse.pressed) 
		{
			skipTarget += elapsed / 3;
		}
		else 
		{
			skipTarget -= elapsed / 5;
		}

		skipTarget = FlxMath.bound(skipTarget, 0, 1);
		skipProgress.amount = FlxMath.lerp(skipProgress.amount, skipTarget, 1 - Math.exp(-elapsed * 18));

		if (skipProgress.amount >= 0.99) 
		{
			skipProgress.amount = 1;
			if (po1 != null) videoEnd();
		}
    }
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
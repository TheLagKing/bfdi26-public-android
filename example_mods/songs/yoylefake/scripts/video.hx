import funkin.data.Highscore;
import funkin.data.ModSave;
import flixel.addons.display.FlxPieDial;

var yoylefakeStart;
var yoylefake1;
var yoylefake2;

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

		yoylefakeStart = new Video4();
		yoylefakeStart.onFormat(() ->
		{
			yoylefakeStart.setGraphicSize(FlxG.width, FlxG.height);
			yoylefakeStart.updateHitbox();
			yoylefakeStart.antialiasing = false;
			yoylefakeStart.cameras = [game.camOther];
		});

		add(yoylefakeStart);

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

		if (yoylefakeStart.load(Paths.video('yoylefakeStart')))
		{
			yoylefakeStart.delayAndStart();
		}

		yoylefakeStart.onStart(() ->
		{
			FlxTween.tween(skipText, {alpha: 1, y: FlxG.height - skipText.height - 10}, 2, {ease: FlxEase.quadOut, onComplete:Void -> can = true});
		});

		yoylefakeStart.onEnd(() -> 
		{
			videoEnd();
		});
	}

	return (cutscene) ? Function_Stop : Function_Continue;
}

function videoEnd() 
{
	can = false;

	cutscene = false;
	PlayState.introCutscene = false;

	yoylefakeStart.destroy();

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
	yoylefake1 = new Video4();
	yoylefake1.onFormat(() ->
	{
		yoylefake1.setGraphicSize(FlxG.width, FlxG.height);
		yoylefake1.updateHitbox();
		yoylefake1.cameras = [camHUD];
	});

	yoylefake1.load(Paths.video('yoylefake'), [Video4.muted]);
	insert(0, yoylefake1); // ayo why was it adding thats sus 😂 //die bitch

    yoylefake2 = new Video4();
	yoylefake2.onFormat(() ->
	{
		yoylefake2.setGraphicSize(FlxG.width, FlxG.height);
		yoylefake2.updateHitbox();
		yoylefake2.cameras = [camOther];
	});

	yoylefake2.load(Paths.video('yoylefakeEnd'), [Video4.muted]);
	add(yoylefake2);
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'dumb video') 
    {
        switch (v1) 
        {
            case 'yoylefake1': yoylefake1.delayAndStart();
			case 'destroy':
				FlxG.camera.flash();
				if (yoylefake1 != null) yoylefake1.destroy();
            case 'yoylefake2':
				var fuck = new FlxSprite().makeGraphic(1,1,FlxColor.WHITE);
				fuck.setGraphicSize(FlxG.width,FlxG.height);
				fuck.updateHitbox();
				fuck.scrollFactor.set();
				fuck.cameras = [camOther]; 
				insert(members.indexOf(yoylefake2)+1,fuck);

				yoylefake2.delayAndStart();
				FlxTween.tween(fuck, {alpha: 0}, 1, {ease: FlxEase.quadOut});

                camHUD.visible = camGame.visible = false;
        }
    }
}

function onEndSong() //think this is neat
{
    new FlxTimer().start(1, () -> 
    {
        FlxTween.tween(camOther, {alpha: 0}, 2, {onComplete: _ -> 
		{
			Highscore.saveSongData('yoylefake', 1, game.songScore, game.percent, Highscore.calculateFC(game.songMisses, game.percent), game.ratingsData[0].hits, game.ratingsData[1].hits, game.ratingsData[2].hits, game.ratingsData[3].hits);
			ModSave.markSongSeen('yoylefake');
			
			FlxG.switchState(()-> new funkin.states.FreeplayState());

			FlxG.sound.music.pause();
			FlxG.sound.music.stop();
			FlxG.sound.playMusic(Paths.music('freeplayMenu'), 0);
		}});
    });

    return Function_Stop;
}

var skipTarget:Float = 0;

function onUpdate(elapsed) 
{
	if (cutscene && yoylefakeStart != null) 
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
			videoEnd();
		}
    }
}
import funkin.objects.Video4;
import funkin.data.Highscore;
import funkin.data.ModSave;

var yoylefake1;
var yoylefake2;

function onCreate() 
{
	yoylefake1 = new Video4();
	yoylefake1.onFormat(()->
	{
		yoylefake1.setGraphicSize(FlxG.width, FlxG.height);
		yoylefake1.updateHitbox();
		yoylefake1.antialiasing = false;
		yoylefake1.cameras = [camHUD];
	});

	yoylefake1.load(Paths.video('yoylefake'), [Video4.muted]);
	insert(0, yoylefake1); // ayo why was it adding thats sus 😂 //die bitch

    yoylefake2 = new Video4();
	yoylefake2.onFormat(()->
	{
		yoylefake2.setGraphicSize(FlxG.width, FlxG.height);
		yoylefake2.updateHitbox();
		yoylefake2.cameras = [camOther];
	});

	yoylefake2.load(Paths.video('yoylefakeEnd'), [Video4.muted]);
	add(yoylefake2);

	Video4.cacheVid(Paths.video('yoylefake'));
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
			Highscore.saveSongData('yoylefake',1,game.songScore,game.percent,Highscore.calculateFC(game.songMisses,game.percent),game.ratingsData[0].hits,game.ratingsData[1].hits,game.ratingsData[2].hits,game.ratingsData[3].hits);
			ModSave.markSongSeen('yoylefake');
			
			FlxG.switchState(()-> new funkin.states.FreeplayState());

			FlxG.sound.music.pause();
			FlxG.sound.music.stop();
			FlxG.sound.playMusic(Paths.music('freeplayMenu'), 0);
		}});
    });
    return Function_Stop;
}
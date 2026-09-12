final list:Array<Dynamic> = 
[
	['yoylefake',1350,800],
	['funny-fellow',900,800],
	['funny-fellow-spooky',700,500],
	['wrong-finger',900,900],
	['wrong-finger-coiny',1000,0],
	['vocal-chords',600,800],
	['oneshot',1000,900],
	['oneshot-pico',1025,950],
	['time',955,25],
	['web-crasher',500,225],
	['web-crasher-gf',500,225],
	['well-rounded',200,325],
	['invitational',4400,1500],
	['invitational-dearest',3200,1350],
	['himsheys',400,200],
	['himsheys-tird',400,240],
	['hey-two',1250,450],
	['hey-two-gf',1300,150],
	['new-friendly',575,510],
	['syskill',4250,1550],
	['syskill-pico',4250,1550],
	['blue-golfball',250,350],
	['blue-golfball-bf',400,150],
	['evil-song',975,750],
	['evil-song-pico',775,675],
	['dotted-line',600,-275],
	['kms',400,300],
	['whos-there',100,320],
	['hard-bargain',675,200],
	['hello-operator',600,725],
	['help-me',875,470],
	['underway',-400,400],
	['bossy',0,250],
	['bossy-lunch',700,250],
	['aldi',425,350],
	['newfoundland',0,0],
	['track26',400,-400],
	['aewbc',100,-300],
	['r(bfdimemes',1500,-50],
	['cyans-new-groove',600,-400]
];

function onCreate () 
{
	FlxG.keys.enabled = true;
    originalOffsets = ClientPrefs.data.comboOffset.copy();
    for (i in 0...4) ClientPrefs.data.comboOffset[i] = 0;
}

function onUpdate() 
{
	if (PlayState.SONG.song.toLowerCase() != 'newfoundland') comboGroup.cameras = [camGame];

    for (i in 0...list.length)
	{
		if (PlayState.SONG.song.toLowerCase() == list[i][0]) 
		{
			comboGroup.x = list[i][1];
			comboGroup.y = list[i][2];
        }
	}
}

var scoreLerp;

function onUpdatePost(elapsed:Float)
{
    scoreLerp = FlxMath.lerp(scoreLerp, PlayState.instance.songScore, 0.1);

	if (PlayState.SONG.song.toLowerCase() != 'newfoundland') PlayState.instance.scoreTxt.text = 'Score: ' + Std.parseInt(scoreLerp);
	else PlayState.instance.scoreTxt.text = Std.parseInt(scoreLerp);
}

function onStartCountdown() 
{
	skipTween = game.skipArrowStartTween;
	game.skipArrowStartTween = true;

	return Function_Continue;
}

function onCountdownStarted() 
{
	var m:Int = (ClientPrefs.data.downScroll ? -1 : 1);
	var i:Int = 0;
	
	for (strum in game.strumLineNotes.members) 
	{
		var player = (i >= game.opponentStrums.length);
		if (!skipTween && PlayState.startOnTime <= 0 && (player || ClientPrefs.data.opponentStrums)) 
		{
			strum.y -= m * 10;
			strum.alpha = 0;
			FlxTween.tween(strum, {y: strum.y + m * 10, alpha: ((ClientPrefs.data.middleScroll && i < game.opponentStrums.length) ? 0.35 : 1)}, 1, {ease: FlxEase.circOut, startDelay: 0.6 + (0.2 * (i % game.opponentStrums.length))});
		}
		
		i ++;
	}

	return Function_Continue;
}
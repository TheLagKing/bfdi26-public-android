var time;
var timeend;

var canStartIntro = false;

function onStartCountdown(){
    if (!canStartIntro) return Function_Stop;
    else return Function_Continue;
}

function onCreate() {
	time = new Video4(0, 0, false);
	time.onFormat(() ->{
		time.setGraphicSize(FlxG.width, FlxG.height);
		time.updateHitbox();
		time.antialiasing = false;
		time.cameras = [camOther];
	});

	add(time);

    timeend = new Video4(0, 0, false);
	timeend.onFormat(() ->{
		timeend.setGraphicSize(FlxG.width, FlxG.height);
		timeend.updateHitbox();
		timeend.antialiasing = false;
		timeend.cameras = [camOther];
	});

	add(timeend);

    timeend.load(Paths.video('time darnell ending final'), [Video4.muted]);

    time.onStart(() ->{
        canStartIntro = true;
        game.startCountdown();
    });

	if (time.load(Paths.video('time darnell_3'), [Video4.muted])) time.delayAndStart();
}

function onEvent(name, v1, v2){
    if (name == ''){
        switch(v1){
            case 'destroyVid':
                time.destroy();
                FlxG.camera.flash();
			case 'showEndVid':
				timeend.delayAndStart();
        }
    }
}
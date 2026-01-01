var bg, shoe, disk, dead, killStuff, titleCard, screen:FlxSprite;
var flashing:Bool = false;
var xOrigin:Float = 0;
var shader = game.createRuntimeShader("RGB_PIN_SPLIT");

function onCreatePost()
{
    game.camGame.filters = ([new ShaderFilter(shader)]);

	for (a in ['evilbg', 'killframe1', 'killframe2', 'killframe3', 'killframe4', 'funnyfellowspooky']) Paths.image('backgrounds/funnyfellow/spooky/' + a);

	FlxG.camera.snapToTarget();

	bg = new FlxSprite(-500, 0).loadGraphic(Paths.image('backgrounds/funnyfellow/spooky/funnyfellowspookybg'));
	insert(0, bg);

	shoe = new FlxSprite(260, 1020);
	shoe.frames = Paths.getSparrowAtlas('backgrounds/funnyfellow/spooky/shoe');
	shoe.animation.addByPrefix('i', 'shoe', 24, true);
	shoe.animation.addByPrefix('animatic', 'animaticshoe', 24, false);
	shoe.animation.play('i', true);
	shoe.animation.finishCallback = (a)->{if (a == 'animatic') shoe.kill();}
	insert(1, shoe);

	disk = new FlxSprite(1000, 1000);
	disk.frames = Paths.getSparrowAtlas('backgrounds/funnyfellow/spooky/diskandpop');
	disk.animation.addByPrefix('i', 'diskandpop', 24, false);
	disk.animation.addByPrefix('animatic', 'animaticcomingdiskandpop', 24, false);
	disk.animation.play('i', false);
	insert(2, disk);

	dead = new FlxSprite(dad.x - 130, dad.y + 400);
	dead.frames = Paths.getSparrowAtlas('backgrounds/funnyfellow/spooky/deadchud');
	dead.animation.addByPrefix('i', 'dead', 24, true);
	dead.animation.play('i', true);
	dead.visible = false;
	addBehindDad(dead);

	remove(boyfriendGroup);
	addBehindGF(boyfriendGroup);

	killStuff = new FlxSprite();
	killStuff.camera = camHUD;
	killStuff.visible = false;
	insert(0, killStuff);

    screen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
    screen.scrollFactor.set();
    screen.updateHitbox();
	screen.screenCenter();
	screen.scale.set(2,2);
	screen.blend = 2;
    screen.alpha = 0;
    addBehindDad(screen);

	if (!ClientPrefs.data.hideCards) 
	{
		titleCard = new FlxSprite().loadGraphic(Paths.image('rendersnlogos/wholesomeexclamationmarksong'));
		titleCard.camera = camOther;
		titleCard.scale.set(0.7, 0.7);
		titleCard.updateHitbox();
		titleCard.screenCenter();
	
		xOrigin = titleCard.x;
		
		titleCard.x = FlxG.width;
		titleCard.alpha = 0;
		insert(0, titleCard);
	}
}

function opponentNoteHitPre(n) if (curBeat >= 268) n.animSuffix = '-alt';

var fakeBeat = 0;
function onBeatHit()
{
	while (fakeBeat < curBeat)
	{
		fakeBeat += 1;

		if (fakeBeat < 60) 
		{
			disk.animation.stop();
			disk.animation.play('i', false);
		}

		if (!ClientPrefs.data.hideCards) 
		{
			if (fakeBeat == 4)  FlxTween.tween(titleCard, {alpha: 1, x: xOrigin}, (Conductor.crochet / 1000) * 8, {ease: FlxEase.cubeOut});
			if (fakeBeat == 12) FlxTween.tween(titleCard, {alpha: 0, x: -titleCard.width}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.cubeIn});
		}

		switch (fakeBeat) 
		{	
			case 56:
				shoe.animation.play('animatic');
				shoe.offset.set(115, 0);
			case 60:
				disk.animation.play('animatic');
				disk.offset.set(10, 12);

				new FlxTimer().start(0.85, Void -> FlxTween.tween(disk, {x: disk.x - 1300}, 1, {onComplete: Void -> disk.kill()}));
			case 68: dead.visible = true;
			case 76:
				titleCard.loadGraphic(Paths.image('rendersnlogos/funnyfellowspooky'));
				titleCard.scale.set(0.6, 0.6);
				titleCard.updateHitbox();
				titleCard.screenCenter();
				xOrigin = titleCard.x;
				titleCard.x = FlxG.width;
				FlxTween.tween(titleCard, {alpha: 1, x: xOrigin}, (Conductor.crochet / 1000) * 6, {ease: FlxEase.cubeOut});
			case 84: FlxTween.tween(titleCard, {alpha: 0, x: -titleCard.width}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.cubeIn});
			case 267:
				flashing = true;
				killStuff.visible = true;
			case 268:
				dad.idleSuffix = '-alt';
				bg.loadGraphic(Paths.image('backgrounds/funnyfellow/spooky/evilbg'));
				flashing = false;
				killStuff.kill();
				screen.alpha = 1;
				shader.setFloat("amount", 0.02);
			case 332: camGame.visible = false;
		}
	}
}

var counter:Int = 0;
function onStepHit()
{
	if (flashing)
	{
		counter += 1;

		killStuff.loadGraphic(Paths.image('backgrounds/funnyfellow/spooky/killframe' + Std.string(counter)));
		killStuff.setGraphicSize(FlxG.width, FlxG.height);
		killStuff.screenCenter();
	}
}

function onEvent(ev,v1,v2) 
{
	if (ev == '' && v1 == 'treat') 
	{
		iconP1.changeIcon(gf.healthIcon);
		healthBar.setColors(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
		FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]));
	} 

	if (ev == '' && v1 == 'trick') 
	{
		iconP1.changeIcon(boyfriend.healthIcon);
		healthBar.setColors(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
		FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
	}
}

/*function goodNoteHit(n) 
{
	switch(n.noteType)
	{
		case '':
			if (iconP1.char != boyfriend.healthIcon)
			{
				iconP1.changeIcon(boyfriend.healthIcon);
				healthBar.setColors(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
				FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
			}
		case 'GF Sing':
			if (iconP1.char != gf.healthIcon)
			{
				iconP1.changeIcon(gf.healthIcon);
				healthBar.setColors(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
				FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]));
			}
	}
}*/
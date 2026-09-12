import funkin.scripting.ModchartAnimateSprite;

var sky:FlxSprite;
var sky_night:FlxSprite;
var mountain:FlxSprite;
var ground:FlxSprite;
var tail:FlxSprite;
var shock:FlxSprite;
var lighting:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 1.6, FlxG.height * 1.6, 0xff1E0D4A);

var walkers:Array<FlxSprite> = [];
var sun:ModchartAnimateSprite;
var skateboard:ModchartAnimateSprite;
var xiru:ModchartAnimateSprite;
var xiruSitting:Bool = false;
var pretzel:ModchartAnimateSprite;
var ink:ModchartAnimateSprite;
var wwft:ModchartAnimateSprite;
var stencil:ModchartAnimateSprite;

var card:FlxSprite;
var darnell:FlxSprite;
var clock:FlxSprite;

function onCreatePost(){
    sky_night = new FlxSprite().loadGraphic(Paths.image('backgrounds/time-darnell/night frickin sky'));
    sky_night.screenCenter();
    sky_night.scrollFactor.set(0.15, 0.15);
    addBehindGF(sky_night);

    sky = new FlxSprite().loadGraphic(Paths.image('backgrounds/time-darnell/normal frickin sky'));
    sky.screenCenter();
    sky.scrollFactor.set(0.15, 0.15);
    addBehindGF(sky);

    mountain = new FlxSprite(-100, 200).loadGraphic(Paths.image('backgrounds/time-darnell/mountaindarnell'));
    mountain.scrollFactor.set(0.5, 0.5);
    addBehindGF(mountain);

    ground = new FlxSprite(-200, 500).loadGraphic(Paths.image('backgrounds/time-darnell/darnellground'));
    addBehindGF(ground);

    tail = new FlxSprite(730, -380).loadGraphic(Paths.image('backgrounds/time-darnell/clockstail'));
    addBehindDad(tail);

    shock = new FlxSprite(750, -300);
    shock.frames = Paths.getSparrowAtlas('backgrounds/time-darnell/shock');
    shock.animation.addByPrefix('i', 'Symbol 12 instance 1', 12, true);
    shock.animation.play('i', true);
    addBehindDad(shock);

    lighting.alpha = 0;
    lighting.blend = 9;
    lighting.scrollFactor.set();
    lighting.screenCenter();
    add(lighting);

    sun = new ModchartAnimateSprite(gf.x + 150, gf.y - 1700, 'backgrounds/time-darnell/sun fall assets');
    sun.addAnim('fall', '2background/sunfall', 24, false);
    sun.visible = false;
    addBehindGF(sun);

    skateboard = new ModchartAnimateSprite(0, gf.y, 'backgrounds/time-darnell/walkers/sboard');
    skateboard.addAnim('idle', '2background/skateboard', 24, true);
    skateboard.playAnim('idle');
    insert(game.members.indexOf(lighting), skateboard);

    xiru = new ModchartAnimateSprite(-100, gf.y, 'backgrounds/time-darnell/xiru boi');
    xiru.addAnim('walk', '2background/xiruwalk', 24, true);
    xiru.addAnim('transition', '2background/xirutransition', 24, false);
    xiru.addAnim('sit', '2background/xirusit', 24, false);
    xiru.addOffset('sit', -3, -58);
    xiru.addAnim('blink', '2background/xirublink', 24, false);
    xiru.addAnim('sun', '2background/xirusun', 24, false);
    xiru.playAnim('walk');
    xiru.animation.finishCallback = (a)->{
        switch(a){
            case 'transition':
                xiru.playAnim('sit');
                xiruSitting = true;
            case 'blink':
                xiru.playAnim('sit');
            case 'sun':
                xiru.playAnim('sit');
        }
    }
    addBehindGF(xiru);

    ink = new ModchartAnimateSprite(-470, -430, 'backgrounds/time-darnell/walkers/inky');   
    ink.addAnim('walk', '2background/inkclimb', 24, false);
    ink.animation.finishCallback = (a)->{
        switch(a){
            case 'walk':
                ink.kill();
        }
    }
    ink.visible = false;
    addBehindDad(ink);

    pretzel = new ModchartAnimateSprite(170, -280, 'backgrounds/time-darnell/walkers/pretzel');   
    pretzel.addAnim('walk', '2background/pretzelclimb', 24, false);
    pretzel.animation.finishCallback = (a)->{
        switch(a){
            case 'walk':
                pretzel.kill();
        }
    }
    pretzel.visible = false;
    addBehindDad(pretzel);

    wwft = new ModchartAnimateSprite(3200, 960, 'backgrounds/time-darnell/walkers/butts with booty butts');   
    wwft.addAnim('walk', 'wwftWalk', 24, true);
    wwft.playAnim('walk');
    insert(game.members.indexOf(lighting), wwft);

    stencil = new ModchartAnimateSprite(0, 500, 'backgrounds/time-darnell/walkers/stencil');   
    stencil.addAnim('idle', '2background/stencilwatch', 24, false);
    stencil.visible = false;
    stencil.animation.finishCallback = (a)->{
        switch(a){
            case 'idle':
                stencil.kill();
        }
    }
    insert(game.members.indexOf(lighting), stencil);

    comboGroup.setPosition(1800, 200);

	if (!ClientPrefs.data.hideCards) 
	{
    card = new FlxSprite().loadGraphic(Paths.image('backgrounds/time-darnell/timedarnell'));
    card.camera = camHUD;
    card.scale.set(0.8, 0.8);
    card.updateHitbox();
    card.screenCenter();
    card.y -= 50;
    card.alpha = 0;
    insert(0, card);

    darnell = new FlxSprite().loadGraphic(Paths.image('backgrounds/time-darnell/darnell1'));
    darnell.camera = camHUD;
    darnell.scale.set(0.5, 0.5);
    darnell.updateHitbox();
    darnell.y = (FlxG.height - darnell.height) + 15;
    darnell.x = 30;
    darnell.alpha = 0;
    insert(0, darnell);

    clock = new FlxSprite().loadGraphic(Paths.image('backgrounds/time-darnell/clock1'));
    clock.camera = camHUD;
    clock.scale.set(0.6, 0.6);
    clock.updateHitbox();
    clock.y = -50;
    clock.alpha = 0;
    clock.x = (FlxG.width - clock.width) - 30;
    insert(0, clock);
    }
}

function onBeatHit(){
    if (xiru.animation.curAnim.name == 'sit' && xiruSitting){
        if (FlxG.random.bool(5)){
            xiru.playAnim('blink');
        }
    }
}

var curPhase:String = 'start';
function onEvent(name, v1, v2){
    if (name == ''){
        switch(v1){
            case 'card':
            		if (!ClientPrefs.data.hideCards) 
		{
                FlxTween.tween(card, {alpha: 1}, 1.5, {ease: FlxEase.cubeOut});
                darnell.y += 30;
                FlxTween.tween(darnell, {y: darnell.y - 30, alpha: 1}, 1.5, {ease: FlxEase.cubeOut});
                clock.y -= 30;
                FlxTween.tween(clock, {y: clock.y + 30, alpha: 1}, 1.5, {ease: FlxEase.cubeOut});
                new FlxTimer().start((Conductor.crochet / 1000) * 12, function(){
                    for (a in [card, clock, darnell]){
                        FlxTween.tween(a, {alpha: 0}, 1, {ease: FlxEase.cubeIn, onComplete: function(){
                            a.destroy();
                        }});
                    }
                });
        }
            case 'shock':
                moveShock(Std.parseFloat(v2));
            case 'night':
                nightTime();
                sun.playAnim('fall');
                sun.visible = true;
                new FlxTimer().start(0.3, function(){
                    xiru.playAnim('sun');
                });
            case 'chorus': gf.idleSuffix = '-alt';
            case 'pretzel':
                pretzel.visible = true;
                pretzel.playAnim('walk');
            case 'skateboard': FlxTween.tween(skateboard, {x: 3300}, 14, {onComplete: function(){skateboard.destroy();}});
            case 'ink':
                ink.visible = true;
                ink.playAnim('walk');
            case 'xiru': FlxTween.tween(xiru, {x: 2750}, 13, {onComplete: function(){xiru.playAnim('transition');}});
            case 'wwft': FlxTween.tween(wwft, {x: -200}, 13, {onComplete: function(){wwft.kill();}});
            case 'stencil':
                stencil.playAnim('idle');
                stencil.visible = true;
            case 'shake':
                game.camGame.shake(0.01, 0.4);
        }
    }
}

function nightTime(){
    FlxTween.tween(lighting, {alpha: 0.33}, (Conductor.crochet / 1000) * 12, {ease: FlxEase.cubeInOut});
    FlxTween.tween(sky, {alpha: 0}, (Conductor.crochet / 1000) * 12, {ease: FlxEase.cubeInOut});
    FlxTween.color(mountain, (Conductor.crochet / 1000) * 12, FlxColor.WHITE, 0xff1A1E26, {ease: FlxEase.cubeInOut});
}

function moveShock(?speed:Float = 1){
    speed ??= 1;
    FlxTween.tween(shock, {y: -50}, 1 * speed);
    FlxTween.tween(shock, {x: 800}, 1 * speed, {ease: FlxEase.cubeIn}).then(
        FlxTween.tween(shock, {x: 640, y: 340}, 0.5 * speed)).then(
            FlxTween.tween(shock, {x: 670, y: 730}, 0.7 * speed)).then(
                FlxTween.tween(shock, {x: 900, y: 680}, 0.6 * speed, {onComplete: function(){
                    shock.setPosition(750, -300);
                }}));
}
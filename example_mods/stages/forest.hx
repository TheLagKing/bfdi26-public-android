import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;
import flixel.effects.FlxFlicker;

var shader = game.createRuntimeShader("adjustColor");
var red = game.createRuntimeShader("red");

var screen, gradient, trees, legs, leafy, vignette, watchingleafy, scream;

var bg1 = [];
var bg2 = [];
var canyon = [];

var leafyX;
var flash = false;
var noteShake = false;
var includeZoom = true;
var includeFlash = false;

var twnTime = 0.6;
var amount = 50;
var shakeAm = 40;
var noteShakeAm = 15;

var perc;
var def;

function onCreate() 
{
    FlxG.camera.bgColor = FlxColor.BLACK;
    FlxG.camera.antialiasing = ClientPrefs.data.antialiasing;

    game.camGame.filters = [new ShaderFilter(shader)];
    game.camHUD.filters  = [new ShaderFilter(shader)];

    red.setFloat('pix', 0.00001);

    Paths.image('backgrounds/whos-there/trees');
    Paths.image('backgrounds/whos-there/songParts');
    Paths.image('backgrounds/whos-there/leafy');
    
    game.addCharacterToList('runhat',0);
    game.addCharacterToList('canbf',0);
    game.addCharacterToList('canbf',0);
    game.addCharacterToList('runhatred',0);

    gradient = FlxGradient.createGradientFlxSprite(FlxG.width * 3, FlxG.height * 2, [0xff225e13, FlxColor.TRANSPARENT], 1, 270);
	gradient.screenCenter();
    gradient.y += 200;
	addBehindDad(gradient);
    bg1.push(gradient);

    trees = new FlxBackdrop(null, 0x01, 1, 1);
    trees.frames = Paths.getSparrowAtlas('backgrounds/whos-there/trees');
    trees.animation.addByPrefix('normal','normalfuckingtrees',0);
    trees.animation.addByPrefix('evil','evilfuckingtrees',0);
    trees.animation.play('normal');
    trees.velocity.x -= 70;
    trees.y -= 925;
    addBehindDad(trees);
    bg1.push(trees);

    var waltzbg = new FlxSprite(-70,-200).loadFromSheet('backgrounds/whos-there/songParts', 'waltzbg'); //scoping
    waltzbg.scrollFactor.set(0.25,0.25);
    waltzbg.scale.set(1.15,1.15);
    addBehindDad(waltzbg);
    bg2.push(waltzbg);

    watchingleafy = new FlxSprite(-20,-200).loadFrames('backgrounds/whos-there/leafy');
    watchingleafy.addAnimByPrefix('evilleafyscream','evilleafyscream');
    watchingleafy.addAndPlay('evilleafywatching','evilleafywatching');
    watchingleafy.alpha = 0;
    addBehindDad(watchingleafy);

    var bfdia5bfloor = new FlxBackdrop(null, 0x01, 0.4, 0.4);
    bfdia5bfloor.frames = Paths.getSparrowAtlas('backgrounds/whos-there/songParts');
    bfdia5bfloor.animation.addByPrefix('bfdia5bfloor','bfdia 5b floor',0);
    bfdia5bfloor.animation.play('bfdia5bfloor');
    bfdia5bfloor.velocity.x -= 100;
    bfdia5bfloor.y = 1040;
    addBehindDad(bfdia5bfloor);
    bg2.push(bfdia5bfloor);

    for (i in bg2) i.alpha = 0.000001;

    var canyonbg = new FlxSprite(-1000).loadGraphic(Paths.image('backgrounds/whos-there/canyon')); //loadFromSheet('backgrounds/whos-there/songParts', 'canyon');
    addBehindBF(canyonbg);
    canyon.push(canyonbg);

    var standingleafy = new FlxSprite(670,320).loadFromSheet('backgrounds/whos-there/songParts', 'canyonevilleafy');
    addBehindBF(standingleafy);
    canyon.push(standingleafy);
    
    for (i in canyon) i.alpha = 0.000001;

    legs = new FlxSprite().loadFrames('characters/whos-there/legs');
    legs.addAnimByPrefix('walk','walk');
    legs.addAnimByPrefix('run','runrunrun');
    legs.addAnimByPrefix('redrun','redrun');
    legs.playAnimation('walk');
    legs.screenCenter();
    addBehindBF(legs);

    scream = new FlxSprite().loadFromSheet('backgrounds/whos-there/leafy', 'evilleafyscream');
    scream.screenCenter();
    scream.cameras = [game.camHUD];
    scream.scale.set(0.5,0.5);
    add(scream);
    scream.visible = false;

    vignette = new FlxSprite().loadImage('backgrounds/whos-there/vignette');
    vignette.screenCenter();
    vignette.cameras = [game.camHUD];
    vignette.scale.set(0.75,0.75);
    vignette.alpha = 0.25;
    add(vignette);

    screen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
    screen.scrollFactor.set();
    screen.updateHitbox();
	screen.screenCenter();
    screen.alpha = 0;
    add(screen);
}

function onCreatePost() 
{
    FlxG.camera.antialiasing = ClientPrefs.data.antialiasing;

    leafy = new FlxSprite(boyfriend.x-300,boyfriend.y+5).loadFrames('backgrounds/whos-there/songParts');
    leafy.addAnimByPrefix('evilerleafy','evilerleafy');
    leafy.addAndPlay('evilleafy','evilleafy');
    add(leafy);

    leafy.visible = false;

    game.iconP1.flipX = true;
    game.iconP2.changeIcon('evilleafy');
    game.healthBar.setColors(FlxColor.fromRGB(255,0,51),FlxColor.fromRGB(255,0,51));
    game.healthBar.flipX = true;
    game.dad.visible = false;

    game.isCameraOnForcedPos = true;
    game.healthGain = 0;

    perc = game.health;
    def = FlxG.camera.zoom;
}

function onSongStart() for (i in opponentStrums) i.x = -1000;

var twn;
function onBeatHit() 
{
    if (flash) 
    {
        shaderTwn();
        leafyRun();

        if (includeZoom) game.triggerEvent('Add Camera Zoom','','',Conductor.songPosition);
        if (includeFlash) 
        {
            FlxTween.cancelTweensOf(screen,['alpha']);

            screen.alpha = 0.2;
            FlxTween.tween(screen, {alpha: 0}, 0.4);
        }
    }

    if (noteShake) shakeNote();
}

function shakeNote() 
{
    for (i in 0...4)
	{
		FlxTween.num(noteShakeAm, 0, 0.3, {ease: FlxEase.circOut}, (penis) -> 
        {
			game.playerStrums.members[i].x = [defaultPlayerStrumX0, defaultPlayerStrumX1, defaultPlayerStrumX2, defaultPlayerStrumX3][i] + FlxG.random.int(-penis, penis);
			game.playerStrums.members[i].y = [defaultPlayerStrumY0, defaultPlayerStrumY1, defaultPlayerStrumY2, defaultPlayerStrumY3][i] + FlxG.random.int(-penis, penis);
		});
	}
}

function shaderTwn() 
{
    if (twn != null) twn.cancel();
    twn = FlxTween.num(amount, 0, 1, {ease: FlxEase.quadOut}, f -> shader.setFloat("contrast", f));

    FlxTween.cancelTweensOf(vignette,['alpha']);

    vignette.alpha = 1;
    FlxTween.tween(vignette, {alpha: 0.3}, 0.5, {ease: FlxEase.quadOut});
}

function leafyRun() 
{
    FlxTween.cancelTweensOf(leafy,['x']);

    leafy.x = leafyX;
    FlxTween.tween(leafy, {x: -(FlxG.width * 1)},twnTime);
}

function onEvent(ev,v1,v2) 
{
    if (ev == 'Change Character')
    {
        if (v2 == 'walkhat') legs.playAnimation('walk');
        if (v2 == 'runhat' || v2 == 'runhatred') legs.playAnimation('run');
        if (v2 == 'runhatred') legs.playAnimation('redrun');

        game.healthBar.setColors(FlxColor.fromRGB(255,0,51),FlxColor.fromRGB(255,0,51));
    }

    if (ev == '') 
    {
        switch (v1) 
        {
            case 'rr': game.camZooming = true;
            case 'amount': amount = v2;
            case 's': shaderTwn();
            case 'scare': scream.visible = true;
            case 'scareend': scream.visible = false;
            case 'trees': trees.velocity.x -= v2;
            case 'preleafy':
                FlxTween.tween(trees.velocity, {x: -1700}, 1, {ease: FlxEase.quadOut, startDelay: 0.5});
            case 'leafyappear':
                leafy.visible = flash = true;

                trees.velocity.x -= 1800;
                game.healthGain = 1;

                FlxG.camera.flash(FlxColor.RED,0.2);
            case 'chill':
                leafy.visible = game.iconP2.visible = game.iconP1.visible = game.healthBar.visible = flash = false;

                for (i in bg2) i.alpha = 1;
                for (i in bg1) i.alpha = 0.000001;
            case 'leafy': FlxTween.tween(watchingleafy, {alpha: 0.6}, 20, {ease: FlxEase.quadOut, startDelay: 2});
            case 'leafy2': watchingleafy.playAnimation('evilleafyscream');
            case 'canyon':
                for (i in bg2) i.kill();
                watchingleafy.kill();

                for (i in canyon) i.alpha = 1;
                
                legs.visible = false;
                game.healthGain = 0;
                game.health = perc;

                game.isCameraOnForcedPos = true;
                FlxTween.tween(game.camFollow, {x: 775, y: 640}, 3.5, {ease: FlxEase.quadInOut});
            case 'back':
                game.isCameraOnForcedPos = false;

                for (i in canyon) i.kill();
                for (i in bg1) i.alpha = 1;
                leafy.visible = legs.visible = flash = true;
                game.healthBar.visible = game.iconP1.visible = game.iconP2.visible = ClientPrefs.data.hideHUD;
                game.healthGain = 1;

                game.defaultCamZoom = def + 0.3;
                FlxG.camera.zoom = def + 0.3;
                
                new FlxTimer().start(2, () -> game.isCameraOnForcedPos = true);
            case 'evilshit':
                gradient.visible = false;
                trees.animation.play('evil');
                leafy.playAnimation('evilerleafy');

                trees.velocity.x -= 2000;

                game.camGame.filters = game.camHUD.filters  = 
                [
                    new ShaderFilter(shader),
                    new ShaderFilter(red)
                ];
            case 'wait':
                noteShake = !noteShake;
                trees.velocity.x -= 2300;
                twnTime = 0.4;

                game.defaultCamZoom = def + 0.2;
                FlxG.camera.zoom = def + 0.2;
            case 'flick':
                quickFlick(1);
        }

        if (v2 == 'l') leafyRun();
        if (v2 == 'cam') game.camGame.visible = !game.camGame.visible;
        if (v2 == 'f') flash = !flash;
        if (v2 == 'ff') includeFlash = !includeFlash;
        if (v2 == 'flick') quickFlick(0);

        if (flash == false) includeFlash = false;
    }

    /*if (ev == 'Trigger' && v1 == 'evilbop') 
    {
        if (game.dad.visible && game.dad.animation.curAnim.name != 'idle-alt') 
        {
            if (twn != null) twn.cancel();
            twn = FlxTween.num(50, 0., 1.5, {ease: FlxEase.quadOut}, f -> shader.setFloat("contrast", f));
        }
    }*/
}

var num = 0;
final pos = [[0, 0, 0], [770, 630, 0.1], [750, 600, 0.2], [700, 550, 0.2], [680, 500, 0.2], [690, 480, 0.2], [685, 430, 0.5], [687, 380, 0.9], [687, 360, 1], [687, 360, 1]];// ill do dis later brah
function quickFlick(nu = 0)
{
    game.camGame.visible = false;
    new FlxTimer().start(0.02, () -> game.camGame.visible = true);

    if (nu > 0) 
    {
        num = num + nu;

        //FlxG.camera.snapToTarget();

        game.camFollow.x = pos[num][0];
        game.camFollow.y = pos[num][1];

        game.defaultCamZoom = game.defaultCamZoom + pos[num][2];
        FlxG.camera.zoom = FlxG.camera.zoom + pos[num][2];

        FlxG.camera.snapToTarget();
    }

    trace(num, pos[num][0], pos[num][1]);
}

var running;
var actualCenter;
function onUpdatePost(e) 
{
    running = (game.boyfriend.curCharacter.indexOf('run') != -1);
    if (running) game.boyfriend.x = Math.sin(Conductor.songPosition / 1500) * 100 + 900;

    legs.x = game.boyfriend.x + (game.boyfriend.width + (running ? -190 : -200));
    legs.y = game.boyfriend.y + (game.boyfriend.height + (running ? 94 : 70));

    actualCenter = (game.healthBar.rightBar.x + FlxMath.lerp(0, game.healthBar.barWidth, game.healthBar.percent / 100) + game.healthBar.barOffset.x); //whatever bruh

    game.iconP1.x = actualCenter - 90;
    game.iconP1.updateHitbox();

    leafyX = boyfriend.x - 300;
}

function opponentNoteHit(note) if (note.noteType == 'No Animation') if (game.health >= 0.4) game.health -= note.hitHealth * 2;
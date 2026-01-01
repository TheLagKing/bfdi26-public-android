package funkin.states;

import funkin.data.WeekData;
import funkin.data.Highscore;

import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import funkin.objects.Character;
import flixel.input.gamepad.FlxGamepad;
import haxe.Json;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

import funkin.states.StoryMenuState;

import flixel.addons.display.FlxBackdrop;

import openfl.filters.ShaderFilter;
import flixel.graphics.tile.FlxGraphicsShader;

class Title extends MusicBeatState
{
	var logo:FlxSprite;
	var enter:FlxSprite;
	var transitioning:Bool = true;
	var cam:FlxCamera;

	var bloom:BloomShader;

	override public function create():Void
	{
		Paths.clearStoredMemory();

		super.create();

		persistentUpdate = persistentDraw = true;
		Main.fpsVar.visible = ClientPrefs.data.showFPS;

		FlxG.mouse.visible = true;
		FlxG.mouse.load(Setup.mouseIdle, 0.12);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music == null) 
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			FlxG.sound.music.fadeIn(5, 0, 0.8);

			FlxG.sound.music.pitch = FlxG.random.float(0.6, 1.2);
			FlxTween.tween(FlxG.sound.music, {pitch: 1}, 3, {ease: FlxEase.cubeOut});
		}

		cam = quickCreateCam();
		cam.alpha = 0.00000001;
		cam.antialiasing = FlxG.camera.antialiasing = ClientPrefs.data.antialiasing;

		FlxG.camera.flash(FlxColor.BLACK,1);
		FlxG.camera.zoom += 1;
		FlxG.camera.y = FlxG.camera.y + 700;

		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 700}, 4, {ease: FlxEase.cubeOut});
		FlxTween.tween(FlxG.camera, {zoom: 1}, 2, {ease: FlxEase.cubeOut});
		FlxTween.tween(cam, {alpha: 1}, 1, {ease: FlxEase.cubeOut, startDelay: 2, onComplete:Void -> transitioning = false});

		var bg4 = new FlxBackdrop(Paths.image('menus/title/normal set'),X,0,0);
		bg4.scale.set(0.4,0.4);
		bg4.color = 0x3b3b3b;
		bg4.antialiasing = ClientPrefs.data.antialiasing;
		bg4.screenCenter();
		bg4.y += 20;

		bg4.velocity.x = (FlxG.random.bool(50) ? FlxG.random.int(-5,-10) : FlxG.random.int(5,10));
		bg4.scrollFactor.set(0.4,0.4);
		add(bg4);

		logo = new FlxSprite().loadFrames('menus/title/logo shiny');
		logo.addAnimByPrefix('idle', 'Symbol 12 copy instance 1', 24, true);
		logo.animation.play('idle', true);
		logo.scale.set(1, 1);
		logo.screenCenter();
		//logo.cameras = [cam];
		logo.y += 100;
		logo.alpha = 0;
		add(logo);

		FlxTween.tween(logo, {y: 30}, 2, {ease: FlxEase.cubeOut, startDelay: 1.5});
		FlxTween.tween(logo.scale, {x: 1.1, y: 1.1}, 2, {ease: FlxEase.cubeOut, startDelay: 1.6});
		FlxTween.tween(logo, {alpha: 1}, 0.7, {ease: FlxEase.cubeOut, startDelay: 1.8});

		var bg3 = new FlxBackdrop(Paths.image('menus/title/normal set'),X,0,0);
		bg3.scale.set(0.6,0.6);
		bg3.color = 0x5e5e5e;
		bg3.antialiasing = ClientPrefs.data.antialiasing;
		bg3.screenCenter();
		bg3.y += 70;

		bg3.velocity.x = (FlxG.random.bool(50) ? FlxG.random.int(-10,-25) : FlxG.random.int(10,25));
		bg3.scrollFactor.set(0.6,0.6);
		add(bg3);

		var bg2 = new FlxBackdrop(Paths.image('menus/title/normal set'),X,0,0);
		bg2.scale.set(0.8,0.8);
		bg2.color = 0xc4c4c4;
		bg2.antialiasing = ClientPrefs.data.antialiasing;
		bg2.screenCenter();
		bg2.y += 130;

		bg2.velocity.x = (FlxG.random.bool(50) ? FlxG.random.int(-25,-50) : FlxG.random.int(25,50));
		bg2.scrollFactor.set(0.75,0.75);
		add(bg2);

		var bg = new FlxBackdrop(Paths.image('menus/title/damaged set'),X,0,0);
		bg.scale.set(0.9,0.9);
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.screenCenter();
		bg.y += 185;

		bg.velocity.x = (FlxG.random.bool(50) ? FlxG.random.int(-40,-100) : FlxG.random.int(40,100));
		bg.scrollFactor.set();
		add(bg);

		enter = new FlxSprite(0,0,Paths.image("menus/notice/notice enter"));
		enter.y = -50;
		enter.x = 1000;
		enter.scale.set(0.5,0.5);
		enter.cameras = [cam];
		add(enter);

		cam.filters = FlxG.camera.filters = [new ShaderFilter((bloom = new BloomShader()))];

		Conductor.bpm = 102;
		Paths.clearUnusedMemory();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null) Conductor.songPosition = FlxG.sound.music.time;

		if (!transitioning && controls.ACCEPT)
		{
			transitioning = true;
			FlxG.sound.play(Paths.sound('enterimpact'));

			FlxTween.num(0.6, 0, 1, {ease: FlxEase.circOut}, f -> bloom.setBloom(f));
			FlxTween.tween(FlxG.camera, {zoom: 0.7}, 1.5, {ease: FlxEase.circOut});
			FlxTween.tween(cam, {alpha: 0}, 2, {ease: FlxEase.cubeOut, startDelay: 1});

			@:privateAccess 
			FlxG.camera._fxFadeColor = FlxColor.BLACK;
			FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 1}, 1, {startDelay: 1, onComplete:Void -> FlxG.switchState(funkin.states.NewMain.new)});
		}
		
		super.update(elapsed);
	}

	public static function quickCreateCam(defDraw:Bool = false):FlxCamera
	{
		var camera = new FlxCamera();
		camera.bgColor = 0x0;
		FlxG.cameras.add(camera,defDraw);
		return camera;
	}
}

private class BloomShader extends FlxGraphicsShader
{
	@:glFragmentSource('
	#pragma header

	uniform float bloom;
	
	const float blurSize=1./512.;
	
	void main()
	{
		vec4 sum = vec4(0);
		vec2 texcoord=openfl_TextureCoordv;
		
		// blur in y (vertical)
		// take nine samples, with the distance blurSize between them
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x-4.*blurSize,texcoord.y))*.05;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x-3.*blurSize,texcoord.y))*.09;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x-2.*blurSize,texcoord.y))*.12;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x-blurSize,texcoord.y))*.15;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y))*.16;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x+blurSize,texcoord.y))*.15;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x+2.*blurSize,texcoord.y))*.12;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x+3.*blurSize,texcoord.y))*.09;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x+4.*blurSize,texcoord.y))*.05;
		
		// blur in y (vertical)
		// take nine samples, with the distance blurSize between them
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y-4.*blurSize))*.05;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y-3.*blurSize))*.09;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y-2.*blurSize))*.12;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y-blurSize))*.15;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y))*.16;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y+blurSize))*.15;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y+2.*blurSize))*.12;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y+3.*blurSize))*.09;
		sum+=flixel_texture2D(bitmap,vec2(texcoord.x,texcoord.y+4.*blurSize))*.05;
		
		vec4 texColor=texture2D(bitmap,openfl_TextureCoordv);
	
		gl_FragColor= sum * bloom + texColor;
	}')

	public function new()
	{
		super();
		setBloom(0);
	}

	public function setBloom(value:Float)
	{
		this.bloom.value = [value, value];
	}
}
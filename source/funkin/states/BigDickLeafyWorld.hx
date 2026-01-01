package funkin.states;

import funkin.shaders.ColorSwap;

import openfl.filters.ShaderFilter;
import flixel.graphics.tile.FlxGraphicsShader;

class BigDickLeafyWorld extends MusicBeatState
{
    var woody:Null<Woody> = null;

    var swap:Null<ColorSwap> = null;
    var evilshader:Null<EvilShader> = null;

    var scream:Null<FlxSound> = null;
    
    var banned:Null<Bool> = null;

    public function new(?banned:Bool = true):Void
    {
        this.banned = banned;
        super();
    }

    override function create()
    {
        super.create();

        FlxG.sound.music.pause();
        FlxG.sound.music.stop();

        flixel.addons.transition.FlxTransitionableState.skipNextTransIn = flixel.addons.transition.FlxTransitionableState.skipNextTransOut = true;

        @:privateAccess FlxG.camera.bgColor = FlxColor.BLACK;
        FlxG.camera.antialiasing = true;
        FlxG.camera.zoom -= 0.3;

        openfl.Lib.application.window.borderless = true;

        FlxG.stage.window.alert("Do better.", "");
        Sys.exit(1);

        //buildworld();
    }

    function buildworld() 
    {
        var bg = flixel.util.FlxGradient.createGradientFlxSprite(2080, 1080, [0xbb000000,0xFFFFFFFF], 1, 90);
        bg.screenCenter();
        bg.scrollFactor.set();
		add(bg);

        var load = new FlxSprite().loadImage('menus/fuuuuuck');
		load.setScale(0.4);
		load.screenCenter();
        load.x += 500;
		add(load);

        woody = new Woody();
        woody.screenCenter();
        woody.updateHitbox();
        add(woody);

        swap = new ColorSwap();
        evilshader = new EvilShader();

        FlxG.camera.filters = [new ShaderFilter(swap.shader)];
        FlxG.camera.follow(woody, 3);

        intro(function () 
		{
            //lazy to type this fancy
            #if !debug
            FlxG.stage.window.onFocusOut.add(function() 
            {
                if (!banned)
                {
                    if (FlxG.random.bool(25)) scream = FlxG.sound.load(Paths.getPath('sounds/screamer.${Paths.SOUND_EXT}', SOUND)).play();
                }
                else scream = FlxG.sound.load(Paths.getPath('sounds/screamer.${Paths.SOUND_EXT}', SOUND)).play();
            });
            
            FlxG.stage.window.onFocusIn.add(function() 
            {
                scream?.stop();
            });
            #end
		});

    }

    function intro(onComplete:Void->Void = null) 
    {
        FlxG.stage.window.alert(banned ? "Do better." : "labudaga baga dick.", "");

        FlxG.sound.load(Paths.getPath('sounds/jumpscaore.${Paths.SOUND_EXT}', SOUND)).play();

        var cam = funkin.states.Title.quickCreateCam();
        cam.antialiasing = ClientPrefs.data.antialiasing;

        var screen = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
        screen.scale.set(FlxG.width, FlxG.height);
        screen.updateHitbox();
        screen.scrollFactor.set();
        screen.cameras = [cam];
        add(screen);

        var leafy = new FlxSprite().loadImage('leafy');
        leafy.scale.set(5,5);
        leafy.scrollFactor.set();
        leafy.screenCenter();
        leafy.cameras = [cam];
        leafy.alpha = 0;
        leafy.antialiasing = ClientPrefs.data.antialiasing;
        add(leafy);

        FlxTimer.wait(0.4, () -> 
        {
            leafy.alpha = 1;
            FlxTween.tween(leafy, {alpha: 0}, 1);
            FlxTween.tween(screen, {alpha: 0}, 1, {startDelay: 1, onComplete:_-> onComplete()});
        });
    }

    override public function update(elapsed:Float):Void 
    {
        evilshader?.update(elapsed / 7);
        super.update(elapsed);
    }
}

private class Woody extends FlxSprite 
{
    final SPEED:Int = 500;

    public function new():Void
    {
        super();

        frames = Paths.getSparrowAtlas('woody');
        animation.addByPrefix("idle", "idle instance 1");
        animation.addByPrefix("walk", "walk instance 1");

        drag.x = SPEED * 4;

        antialiasing = true;
    }

    override public function update(elapsed:Float):Void 
    {
        super.update(elapsed);

        var LEFT = FlxG.keys.anyPressed([LEFT, A]);
        var RIGHT = FlxG.keys.anyPressed([RIGHT, D]);

        var UP = FlxG.keys.anyPressed([UP, W]);
        var DOWN = FlxG.keys.anyPressed([DOWN, S]);

        if (((LEFT || RIGHT) || (UP || DOWN)) && (!(LEFT && RIGHT) && !(UP && DOWN))) 
        {
            animation.play('walk');
        } else animation.play('idle');

        velocity.x = (if (LEFT) -SPEED else if (RIGHT) SPEED else 0);
        velocity.y = (if (UP) -SPEED else if (DOWN) SPEED else 0);

        if ((LEFT && RIGHT) && (UP && DOWN)) velocity.x = velocity.y = 0;

        flipX = (LEFT ? true : false);

        //trace('is the sprite flipped? $flipX. sprite X velocity: ${velocity.x}, Y velocity: ${velocity.y}. sprite X: $x, Y: $y');
    }
}

private class EvilShader extends FlxGraphicsShader //nice
{
	@:glFragmentSource("
    #pragma header
    
    uniform float iTime;
    uniform float u_mix;
    
    vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
    
    float rand(vec2 n) { 
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 1.5453);
    }

    float perlin(vec2 p){
    vec2 ip = floor(p);
    vec2 u = fract(p);
    u = u*u*(3.0-2.0*u);
	
	float res = mix(
		mix(rand(ip),rand(ip+vec2(1.0,0.0)),u.x),
		mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),u.x),u.y);
	return res*res;
    }

    float avg(vec4 color) {
    float displacement = (color.r/color.r*color.r)*sin(iTime/2.);
     // Threshold to determine if the displacement is minimal
    float threshold = 0.011125;

    // Return 0 if the displacement is below the threshold, otherwise return the calculated displacement
    return (abs(displacement) < threshold) ? 0.0 : displacement;
    }

    // New function to create pixelated texture coordinates
    vec2 pixelate(vec2 coord, float pixelSize) {
    return floor(coord * pixelSize) / pixelSize;
    }
    
    vec2 getBufferedUV() //lazy
    {
    float drunk = 0.0;
    
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = openfl_TextureCoordv.xy;
    vec2 normalizedCoord = mod((fragCoord.xy + vec2(0, drunk)) / openfl_TextureSize.xy, 1.0);
    
    // Mirror the UV coordinates at the top and bottom
    vec2 mirroredUV = vec2(uv.x, 1.0 - abs(uv.y * 2.0 - 1.0));

    // Pixelation factor (higher values for more pixelation)
    float pixelationFactor = cos(iTime)+sin(iTime/4.0)*512.0;

    // Use pixelated texture coordinates for displacement
    vec2 pixelatedCoord = pixelate(normalizedCoord, pixelationFactor);
    vec4 displace = flixel_texture2D(bitmap, vec2(pixelatedCoord));
    
    //datamosh effect
    float displaceFactor = 0.2;
    vec2 datamoshUV = uv + displace.gr * displaceFactor;

    return uv + displace.gr * displaceFactor;
    }
    
    vec4 getBufferOutput(vec2 uv)
    {
    float drunk = 0.0;
    
    // Normalized pixel coordinates (from 0 to 1)
    vec2 normalizedCoord = mod((fragCoord.xy + vec2(0, drunk)) / openfl_TextureSize.xy, 1.0);
    
    // Mirror the UV coordinates at the top and bottom
    vec2 mirroredUV = vec2(uv.x, 1.0 - abs(uv.y * 2.0 - 1.0));

    // Pixelation factor (higher values for more pixelation)
    float pixelationFactor = cos(iTime)+sin(iTime/4.0)*512.0;

    // Use pixelated texture coordinates for displacement
    vec2 pixelatedCoord = pixelate(normalizedCoord, pixelationFactor);
    vec4 displace = flixel_texture2D(bitmap, vec2(pixelatedCoord));
    
    //datamosh effect
    float displaceFactor = 0.2;
    vec2 datamoshUV = uv + displace.gr * displaceFactor;
       
    // Output to screen
    // vec4 datamosh = texture(bitmap, datamoshUV);

    return flixel_texture2D(bitmap, datamoshUV);
    }
    
    vec3 colorVariation(vec2 coord, float time) {
    // Generate Perlin noise based on the coordinate and time
    float noiseValue = perlin(coord * 1.0 + time * 1.0);

    // Map the noise value to a color offset
    vec3 colorOffset = vec3(
        sin(noiseValue * 120.0) * 12.95 + 0.0905,
        cos(noiseValue * 10.0) / 2.9095 + 0.0905,
        sin(noiseValue*12.0) * 0.9395 + 0.01025
    );

    return colorOffset;
    }
    
    void main()
    {

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = getBufferedUV();

    // Pixelation factor (higher values for more pixelation)
    float pixelationFactor = sin(iTime) + sin(iTime / 8.0) * 256.0;
    
    
    // Use pixelated texture coordinates for displacement
    vec2 pixelatedCoord = pixelate(uv, pixelationFactor);
    
    // Create displacement vector
    vec4 displace = getBufferOutput(uv);
    
    
    displace.rg *= vec2(cos(iTime + pixelatedCoord.y * cos(iTime/2.0)*12.0) * 0.5 + 0.5, sin(iTime + pixelatedCoord.y * 10.0) * 0.5 + 0.5);

    // Datamosh effect
    float displaceFactor = .92125 + sin(iTime);
    vec2 datamoshUV = uv + displace.rg / displaceFactor;

    vec4 datamosh = getBufferOutput(datamoshUV);
    vec4 newColor = vec4(datamosh.rgb + colorVariation(datamosh.rg, iTime), 1.0);

    newColor = mix(flixel_texture2D(bitmap,datamoshUV),newColor,u_mix);

    
    gl_FragColor = newColor;
    }
    ")

	public function new()
	{
		super();

        this.iTime.value = [0, 0];
		setU_mix(0);
	}
	
	// lazy to type a get setter
	public function setU_mix(value:Float)
	{
		this.u_mix.value = [value, value];
	}

	public function update(e:Float)
	{
		this.iTime.value[0] += e;
	}
}
package funkin.scripting;

import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxAxes;

class ModchartSprite extends FlxSprite
{
	public var animOffsets:Map<String, Array<Float>> = new Map<String, Array<Float>>();
	public var func:Void->Void = null; //fancy

	public function new(?x:Float = 0, ?y:Float = 0, ?graphic:FlxGraphicAsset)
	{
		super(x, y, graphic);
		// antialiasing = ClientPrefs.data.antialiasing;
	}
	
	public function playAnim(name:String, forced:Bool = false, ?reverse:Bool = false, ?startFrame:Int = 0)
	{
		animation.play(name, forced, reverse, startFrame);
		
		var daOffset = animOffsets.get(name);
		if (animOffsets.exists(name)) offset.set(daOffset[0], daOffset[1]);
	}
	
	public function addOffset(?name:String, ?x:Float, ?y:Float)
	{
		animOffsets.set(name, [x, y]);
	}
	
	public function loadImage(path:String, ?lib:String, anim:Bool = false, w:Int = 0, h:Int = 0, unique:Bool = false, ?key:String)
	{
		this.loadGraphic(Paths.image(path, lib), anim, w, h, unique, key);
		return this;
	}
	
	public function loadFrames(path:String)
	{
		if (Paths.fileExists('images/$path.xml',TEXT))
		{
			frames = Paths.getSparrowAtlas(path);
		}
		return this;
	}
	
	public function loadFromSheet(path:String, anim:String, fps:Int = 24)
	{
		loadFrames(path);
		animation.addByPrefix(anim, anim, fps);
		animation.play(anim);
		if (animation.curAnim == null || animation.curAnim.numFrames == 1)
		{
			active = false;
		}
		
		return this;
	}

	public function addAndPlay(name:String,prefix:String,fps:Int = 24,looped:Bool = true)
	{
		animation.addByPrefix(name,prefix,fps,looped);
		animation.play(name);
	}

	public function addAnimByPrefix(name:String,prefix:String,fps:Int = 24,looped:Bool = true)
	{
		animation.addByPrefix(name,prefix,fps,looped);
	}

	public function playAnimation(name:String,forced:Bool = true)
	{
		animation.play(name,forced);
	}

	public function getCurAnimName():String
	{
		return this.animation.curAnim.name;
	}
	
	/**
	 * applies shader to sprite BUT checks if its allowed to.
	 * @param useFramePixel prevents frame clipping on shader usage.
	 */
	public function applyShader(shader:flixel.system.FlxAssets.FlxShader,useFramePixel = false)
	{
		if (!ClientPrefs.data.shaders) return;
		this.useFramePixels = useFramePixel;
		this.shader = shader;
	}

	public function centerOnSprite(spr:FlxSprite, axes:FlxAxes = XY)
	{
		if (axes.x) this.x = spr.x + (spr.width - this.width) / 2;
		if (axes.y) this.y = spr.y + (spr.height - this.height) / 2;
	}

	public function setScale(scaleX:Float, ?scaleY:Float, updateHB:Bool = true)
	{
		scaleY = scaleY == null ? scaleX : scaleY;
		this.scale.set(scaleX, scaleY);
		if (updateHB) this.updateHitbox();
	}
	
	public function makeScaledGraphic(width:Float = 1, height:Float = 1, color:FlxColor = FlxColor.WHITE)
	{
		makeGraphic(1, 1, color);
		scale.set(width, height);
		updateHitbox();
		return this;
	}

	public function setFunction(func:Void->Void = null) 
	{
		this.func = func;
	}
}
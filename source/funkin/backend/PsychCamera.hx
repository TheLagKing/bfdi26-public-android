package funkin.backend;

import animate.internal.RenderTexture;
import flash.geom.ColorTransform;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFrame;
import flixel.graphics.tile.FlxDrawQuadsItem;
import flixel.graphics.tile.FlxDrawTrianglesItem;
import flixel.math.FlxMatrix;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxShader;

import funkin.backend.animation.FixedBitmapData;
import funkin.shaders.RuntimeCustomBlendShader;

import openfl.Lib;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.OpenGLRenderer;

using funkin.backend.animation.BitmapDataUtil;

// PsychCamera handles followLerp based on elapsed
// and stops camera from snapping at higher framerates

@:access(openfl.display.DisplayObject)
@:access(openfl.display.BitmapData)
@:access(openfl.display.OpenGLRenderer)
@:access(openfl.geom.ColorTransform)
@:access(flixel.graphics.FlxGraphic)
@:access(flixel.graphics.frames.FlxFrame)
class PsychCamera extends FlxCamera
{
	static final KHR_BLEND_MODES:Array<BlendMode> = [
		BlendMode.DARKEN,
		BlendMode.HARDLIGHT,
		#if !desktop BlendMode.LIGHTEN, #end
		BlendMode.OVERLAY,
		BlendMode.DIFFERENCE,
		BlendMode.COLORDODGE,
		BlendMode.COLORBURN,
		BlendMode.SOFTLIGHT,
		BlendMode.EXCLUSION,
		BlendMode.HUE,
		BlendMode.SATURATION,
		BlendMode.COLOR,
		BlendMode.LUMINOSITY
	];

	static final SHADER_REQUIRED_BLEND_MODES:Array<BlendMode> = [BlendMode.INVERT];

	var _blendShader:RuntimeCustomBlendShader;
	var _backgroundFrame:FlxFrame;
	var _blendRenderTexture:RenderTexture;
	var _backgroundRenderTexture:RenderTexture;
	var _cameraTexture:FixedBitmapData;
	var _cameraMatrix:FlxMatrix;

	@:nullSafety(Off)
	public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0, zoom:Float = 0)
	{
		super(x, y, width, height, zoom);

		_backgroundFrame = new FlxFrame(new FlxGraphic('', null));
		_backgroundFrame.frame = new FlxRect();

		_blendShader = new RuntimeCustomBlendShader();

		_backgroundRenderTexture = new RenderTexture(this.width, this.height);
		_blendRenderTexture = new RenderTexture(this.width, this.height);

		_cameraMatrix = new FlxMatrix();

		_cameraTexture = FixedBitmapData.create(this.width, this.height);
	}

	override function drawPixels(?frame:FlxFrame, ?pixels:BitmapData, matrix:FlxMatrix, ?transform:ColorTransform, ?blend:BlendMode, ?smoothing:Bool = false,
      ?shader:FlxShader):Void
	{
		#if mobile
		var shouldUseShader:Bool = blend != null && (KHR_BLEND_MODES.contains(blend) || SHADER_REQUIRED_BLEND_MODES.contains(blend));

		if (shouldUseShader)
		{
			_cameraTexture.drawCameraScreen(this);

			_backgroundFrame.frame.set(0, 0, this.width, this.height);

			// Clear the camera's graphics
			// It'll get redrawn anyway
			this.clearDrawStack();
			this.canvas.graphics.clear();

			_blendRenderTexture.init(this.width, this.height);
			_blendRenderTexture.drawToCamera((camera, frameMatrix) ->
			{
				var pivotX:Float = width / 2;
				var pivotY:Float = height / 2;

				frameMatrix.copyFrom(matrix);
				frameMatrix.translate(-pivotX, -pivotY);
				frameMatrix.scale(this.scaleX, this.scaleY);
				frameMatrix.translate(pivotX, pivotY);
				camera.drawPixels(frame, pixels, frameMatrix, transform, null, smoothing, shader);
			});
			_blendRenderTexture.render();

			_blendShader.sourceSwag = _blendRenderTexture.graphic.bitmap;
			_blendShader.backgroundSwag = _cameraTexture;

			_blendShader.blendSwag = blend;
			_blendShader.updateViewInfo(width, height, this);

			_backgroundFrame.parent.bitmap = _blendRenderTexture.graphic.bitmap;

			// On some displays, the DPI can be less than 1, which causes the blend shader to look bad
			// We just clamp the scale to 1 to avoid this!
			var clampedScale:Float = Math.max(1, Lib.current.stage.window.scale);

			_backgroundRenderTexture.init(Std.int(this.width * clampedScale), Std.int(this.height * clampedScale));
			_backgroundRenderTexture.drawToCamera((camera, frameMatrix) ->
			{
				camera.zoom = this.zoom;
				matrix.scale(clampedScale, clampedScale);
				camera.drawPixels(_backgroundFrame, null, matrix, canvas.transform.colorTransform, null, false, _blendShader);
			});

			_backgroundRenderTexture.render();

			// Resize the result back to the camera.
			_cameraMatrix.identity();
			_cameraMatrix.scale(1 / (this.scaleX * clampedScale), 1 / (this.scaleY * clampedScale));
			_cameraMatrix.translate(((width - width / this.scaleX) * 0.5), ((height - height / this.scaleY) * 0.5));

			super.drawPixels(_backgroundRenderTexture.graphic.imageFrame.frame, null, _cameraMatrix, null, null, smoothing, null);

			return;
		}
		#end

		super.drawPixels(frame, pixels, matrix, transform, blend, smoothing, shader);
	}

	override function startQuadBatch(graphic:FlxGraphic, colored:Bool, hasColorOffsets:Bool = false, ?blend:BlendMode, smooth:Bool = false,
      ?shader:FlxShader):FlxDrawQuadsItem
    {
		#if mobile
		if (KHR_BLEND_MODES.contains(blend) || SHADER_REQUIRED_BLEND_MODES.contains(blend))
		{
			var itemToReturn = null;

			if (FlxCamera._storageTilesHead != null)
			{
				itemToReturn = FlxCamera._storageTilesHead;
				var newHead = FlxCamera._storageTilesHead.nextTyped;
				itemToReturn.reset();
				FlxCamera._storageTilesHead = newHead;
			}
			else
			{
				itemToReturn = new FlxDrawQuadsItem();
			}

			// TODO: catch this error when the dev actually messes up, not in the draw phase
			//if (graphic.isDestroyed) throw 'Cannot queue ${graphic.key}. This sprite was destroyed.';

			itemToReturn.graphics = graphic;
			itemToReturn.antialiasing = smooth;
			itemToReturn.colored = colored;
			itemToReturn.hasColorOffsets = hasColorOffsets;
			itemToReturn.blend = blend;

			@:nullSafety(Off)
			itemToReturn.shader = shader;

			itemToReturn.nextTyped = _headTiles;
			_headTiles = itemToReturn;

			if (_headOfDrawStack == null)
			{
				_headOfDrawStack = itemToReturn;
			}

			if (_currentDrawItem != null)
			{
				_currentDrawItem.next = itemToReturn;
			}

			_currentDrawItem = itemToReturn;

			return itemToReturn;
		}
		#end

		return super.startQuadBatch(graphic, colored, hasColorOffsets, blend, smooth, shader);
	}

	override function startTrianglesBatch(graphic:FlxGraphic, smoothing:Bool = false, isColored:Bool = false, ?blend:BlendMode, ?hasColorOffsets:Bool,
		?shader:FlxShader):FlxDrawTrianglesItem
	{
		#if mobile
		if (KHR_BLEND_MODES.contains(blend) || SHADER_REQUIRED_BLEND_MODES.contains(blend))
			return getNewDrawTrianglesItem(graphic, smoothing, isColored, blend, hasColorOffsets, shader);
		#end

		return super.startTrianglesBatch(graphic, smoothing, isColored, blend, hasColorOffsets, shader);
	}

	override public function update(elapsed:Float):Void
	{
		// follow the target, if there is one
		if (target != null)
		{
			updateFollowDelta(elapsed);
		}
		
		updateScroll();
		updateFlash(elapsed);
		updateFade(elapsed);
		
		flashSprite.filters = filtersEnabled ? filters : null;
		
		updateFlashSpritePosition();
		updateShake(elapsed);
	}

	public function updateFollowDelta(?elapsed:Float = 0):Void
	{
		// Either follow the object closely,
		// or double check our deadzone and update accordingly.
		if (deadzone == null)
		{
			target.getMidpoint(_point);
			_point.addPoint(targetOffset);
			_scrollTarget.set(_point.x - width * 0.5, _point.y - height * 0.5);
		}
		else
		{
			var edge:Float;
			var targetX:Float = target.x + targetOffset.x;
			var targetY:Float = target.y + targetOffset.y;
			
			if (style == SCREEN_BY_SCREEN)
			{
				if (targetX >= viewRight)
				{
					_scrollTarget.x += viewWidth;
				}
				else if (targetX + target.width < viewLeft)
				{
					_scrollTarget.x -= viewWidth;
				}
				
				if (targetY >= viewBottom)
				{
					_scrollTarget.y += viewHeight;
				}
				else if (targetY + target.height < viewTop)
				{
					_scrollTarget.y -= viewHeight;
				}
				
				// without this we see weird behavior when switching to SCREEN_BY_SCREEN at arbitrary scroll positions
				bindScrollPos(_scrollTarget);
			}
			else
			{
				edge = targetX - deadzone.x;
				if (_scrollTarget.x > edge)
				{
					_scrollTarget.x = edge;
				}
				edge = targetX + target.width - deadzone.x - deadzone.width;
				if (_scrollTarget.x < edge)
				{
					_scrollTarget.x = edge;
				}
				
				edge = targetY - deadzone.y;
				if (_scrollTarget.y > edge)
				{
					_scrollTarget.y = edge;
				}
				edge = targetY + target.height - deadzone.y - deadzone.height;
				if (_scrollTarget.y < edge)
				{
					_scrollTarget.y = edge;
				}
			}
			
			if ((target is FlxSprite))
			{
				if (_lastTargetPosition == null)
				{
					_lastTargetPosition = FlxPoint.get(target.x, target.y); // Creates this point.
				}
				_scrollTarget.x += (target.x - _lastTargetPosition.x) * followLead.x;
				_scrollTarget.y += (target.y - _lastTargetPosition.y) * followLead.y;
				
				_lastTargetPosition.x = target.x;
				_lastTargetPosition.y = target.y;
			}
		}
		
		var mult:Float = 1 - Math.exp(-elapsed * followLerp);
		scroll.x += (_scrollTarget.x - scroll.x) * mult;
		scroll.y += (_scrollTarget.y - scroll.y) * mult;
	}

	#if (flixel < "6.0.0")
	override function set_followLerp(value:Float)
	{
		return followLerp = value;
	}
	#end

	override function destroy():Void
	{
		super.destroy();

		_blendRenderTexture.destroy();
		_backgroundRenderTexture.destroy();
		_cameraTexture.dispose();
	}
}

/*
class PsychCamera extends FlxCamera //flixel 6.1.1 ? //i might finish this later
{
	public var smoothCam:Bool = false;
	public var smoothCamTracker:Float = 0;
	public var smoothCamStyle:EaseFunction = FlxEase.smootherStepInOut;

	override public function update(elapsed:Float):Void
	{
		// follow the target, if there is one
		if (target != null)
		{
			updateFollowDelta(elapsed);
		}

		updateScroll();
		updateFlash(elapsed);
		updateFade(elapsed);

		flashSprite.filters = filtersEnabled ? filters : null;

		updateFlashSpritePosition();
		updateShake(elapsed);
	}

	public function updateFollowDelta(?elapsed:Float = 0):Void
	{
		// Either follow the object closely,
		// or double check our deadzone and update accordingly.
		if (deadzone == null)
		{
			target.getMidpoint(_point);
			_point.addPoint(targetOffset);
			_scrollTarget.set(_point.x - width * 0.5, _point.y - height * 0.5);
		}
		else
		{
			var edge:Float;
			var targetX:Float = target.x + targetOffset.x;
			var targetY:Float = target.y + targetOffset.y;

			if (style == SCREEN_BY_SCREEN)
			{
				if (targetX >= viewRight)
				{
					_scrollTarget.x += viewWidth;
				}
				else if (targetX + target.width < viewLeft)
				{
					_scrollTarget.x -= viewWidth;
				}

				if (targetY >= viewBottom)
				{
					_scrollTarget.y += viewHeight;
				}
				else if (targetY + target.height < viewTop)
				{
					_scrollTarget.y -= viewHeight;
				}

				// without this we see weird behavior when switching to SCREEN_BY_SCREEN at arbitrary scroll positions
				bindScrollPos(_scrollTarget);
			}
			else
			{
				edge = targetX - deadzone.x;
				if (_scrollTarget.x > edge)
				{
					_scrollTarget.x = edge;
				}
				edge = targetX + target.width - deadzone.x - deadzone.width;
				if (_scrollTarget.x < edge)
				{
					_scrollTarget.x = edge;
				}

				edge = targetY - deadzone.y;
				if (_scrollTarget.y > edge)
				{
					_scrollTarget.y = edge;
				}
				edge = targetY + target.height - deadzone.y - deadzone.height;
				if (_scrollTarget.y < edge)
				{
					_scrollTarget.y = edge;
				}
			}

			if ((target is FlxSprite))
			{
				if (_lastTargetPosition == null)
				{
					_lastTargetPosition = FlxPoint.get(target.x, target.y); // Creates this point.
				}
				_scrollTarget.x += (target.x - _lastTargetPosition.x) * followLead.x;
				_scrollTarget.y += (target.y - _lastTargetPosition.y) * followLead.y;

				_lastTargetPosition.x = target.x;
				_lastTargetPosition.y = target.y;
			}
		}

		var mult:Float = 1 - Math.exp(-elapsed * followLerp / (1 / 60));
		if (!smoothCam)
		{
			scroll.x += (_scrollTarget.x - scroll.x) * mult;
			scroll.y += (_scrollTarget.y - scroll.y) * mult;
		}
		else
		{
			if ((Math.round(scroll.x) == Math.round(_scrollTarget.x) && Math.round(scroll.y) == Math.round(_scrollTarget.y))
				|| smoothCamTracker >= 0.98)
				smoothCamTracker = FlxMath.lerp(smoothCamTracker, 0, mult);
			else
				smoothCamTracker = FlxMath.lerp(smoothCamTracker, 1, mult);
			scroll.x = FlxMath.lerp(scroll.x, _scrollTarget.x, FlxMath.lerp(0, mult, smoothCamStyle(smoothCamTracker)));
			scroll.y = FlxMath.lerp(scroll.y, _scrollTarget.y, FlxMath.lerp(0, mult, smoothCamStyle(smoothCamTracker)));
		}
		// trace('lerp on this frame: $mult');
	}
}
*/

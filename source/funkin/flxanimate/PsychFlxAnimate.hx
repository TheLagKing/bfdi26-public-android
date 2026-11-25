package funkin.flxanimate;

import flixel.util.FlxDestroyUtil;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.graphics.FlxGraphic;
import flxanimate.frames.FlxAnimateFrames;
import flxanimate.data.AnimationData;
import flxanimate.FlxAnimate as OriginalFlxAnimate;
import openfl.utils.Assets;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

class PsychFlxAnimate extends OriginalFlxAnimate
{
	public function loadAtlasEx(img:FlxGraphicAsset, pathOrStr:String = null, myJson:Dynamic = null)
	{
		var animJson:Dynamic = null;
		if (myJson is String)
		{
			var trimmed:String = pathOrStr.trim();
			trimmed = trimmed.substr(trimmed.length - 5).toLowerCase();
			if (trimmed == '.json') myJson = File.getContent(myJson);
			animJson = haxe.Json.parse(_removeBOM(myJson));
		}
		else animJson = myJson;

		// Ensure SD exists
		if (animJson != null && (!Reflect.hasField(animJson, "SD") || Reflect.field(animJson, "SD") == null))
			Reflect.setField(animJson, "SD", {});

		if (animJson != null && Reflect.hasField(animJson, "SD"))
		{
			var sd:Dynamic = Reflect.field(animJson, "SD");

			// For every SN reference in the timeline, load LIBRARY/<SN>.json.
			var tl:Dynamic = Reflect.field(animJson, "TL");
			if (tl != null && Reflect.hasField(tl, "L"))
				_resolveSymbolsInLayers(Reflect.field(tl, "L"), sd);

			// Also handle the root STI symbol if it references something.
			var sti:Dynamic = Reflect.field(animJson, "STI");
			if (sti != null && Reflect.hasField(sti, "SI"))
				_resolveSymbolInInstance(Reflect.field(sti, "SI"), sd);

			// Recursively resolve symbols that the loaded ones reference.
			var safety:Int = 0;
			var unresolved:Bool = true;
			while (unresolved && safety < 20)
			{
				unresolved = false;
				for (key in Reflect.fields(sd))
				{
					var sym:Dynamic = Reflect.field(sd, key);
					if (sym == null || !Reflect.hasField(sym, "L")) continue;
					if (_resolveSymbolsInLayers(Reflect.field(sym, "L"), sd))
						unresolved = true;
				}
				safety++;
			}

			trace('PsychFlxAnimate: SD has ${Reflect.fields(sd).length} symbols after resolution');
		}

		// Standard spritemap parse
		var isXml:Null<Bool> = null;
		var myData:Dynamic = pathOrStr;
		var t:String = pathOrStr.trim();
		t = t.substr(t.length - 5).toLowerCase();

		if (t == '.json') { myData = File.getContent(pathOrStr); isXml = false; }
		else if (t.substr(1) == '.xml') { myData = File.getContent(pathOrStr); isXml = true; }
		myData = _removeBOM(myData);

		switch (isXml)
		{
			case true:  myData = Xml.parse(myData);
			case false: myData = haxe.Json.parse(myData);
			case null:
				try { myData = haxe.Json.parse(myData); isXml = false; }
				catch (e) { myData = Xml.parse(myData); isXml = true; }
		}

		anim._loadAtlas(cast animJson);
		if (!isXml) frames = FlxAnimateFrames.fromSpriteMap(cast myData, img);
		else        frames = FlxAnimateFrames.fromSparrow(cast myData, img);
		origin = anim.curInstance.symbol.transformationPoint;
	}

	// Walk every layer's every frame's every element, find SN references, load LIBRARY/<SN>.json
	static function _resolveSymbolsInLayers(layers:Array<Dynamic>, sd:Dynamic):Bool
	{
		var anyLoaded:Bool = false;
		if (layers == null) return false;
		for (layer in layers)
		{
			if (layer == null || !Reflect.hasField(layer, "FR")) continue;
			for (frame in Reflect.field(layer, "FR"))
			{
				if (frame == null || !Reflect.hasField(frame, "E")) continue;
				for (el in Reflect.field(frame, "E"))
				{
					if (el == null) continue;
					if (Reflect.hasField(el, "SI"))
						if (_resolveSymbolInInstance(Reflect.field(el, "SI"), sd)) anyLoaded = true;
					if (Reflect.hasField(el, "ASI"))
						if (_resolveSymbolInInstance(Reflect.field(el, "ASI"), sd)) anyLoaded = true;
				}
			}
		}
		return anyLoaded;
	}

	static function _resolveSymbolInInstance(si:Dynamic, sd:Dynamic):Bool
	{
		if (si == null || !Reflect.hasField(si, "SN")) return false;
		var sn:String = Reflect.field(si, "SN");
		if (sn == null || sn == "" || Reflect.hasField(sd, sn)) return false;

		var loaded:Dynamic = _loadLibrarySymbol(sn);
		if (loaded != null)
		{
			Reflect.setField(sd, sn, loaded);
			trace('PsychFlxAnimate: loaded LIBRARY/$sn.json');
			return true;
		}
		trace('PsychFlxAnimate: could not find LIBRARY/$sn.json');
		return false;
	}

	static function _loadLibrarySymbol(sn:String):Dynamic
	{
		var candidates:Array<String> = [
			"LIBRARY/" + sn + ".json",
			"library/" + sn + ".json",
			"images/LIBRARY/" + sn + ".json",
			"images/library/" + sn + ".json"
		];

		// Also try with "/" replaced by "_" in case the folder uses flattened names
		var flat:String = sn.split("/").join("_");
		candidates.push("LIBRARY/" + flat + ".json");
		candidates.push("images/LIBRARY/" + flat + ".json");

		for (c in candidates)
		{
			var content:String = null;
			#if sys try { content = File.getContent(c); } catch (_:Dynamic) {} #end
			if (content == null) try { content = Assets.getText(c); } catch (_:Dynamic) {}
			if (content == null) continue;

			try
			{
				var parsed:Dynamic = haxe.Json.parse(_removeBOM(content));
				if (Reflect.hasField(parsed, "AN") && Reflect.hasField(parsed.AN, "TL"))
					parsed = Reflect.field(parsed.AN, "TL");
				return parsed;
			}
			catch (e:Dynamic) trace('PsychFlxAnimate: bad JSON $c: $e');
		}
		return null;
	}

	override function draw()
	{
		if (anim.curInstance == null || anim.curSymbol == null) return;
		super.draw();
	}

	override function destroy()
	{
		try { super.destroy(); }
		catch (e:haxe.Exception)
		{
			anim.curInstance = FlxDestroyUtil.destroy(anim.curInstance);
			anim.stageInstance = FlxDestroyUtil.destroy(anim.stageInstance);
			anim.metadata.destroy();
			anim.symbolDictionary = null;
		}
	}

	function _removeBOM(str:String)
	{
		if (str.charCodeAt(0) == 0xFEFF) str = str.substr(1);
		return str;
	}

	public function pauseAnimation()
	{
		if (anim.curInstance == null || anim.curSymbol == null) return;
		anim.pause();
	}

	public function resumeAnimation()
	{
		if (anim.curInstance == null || anim.curSymbol == null) return;
		anim.play();
	}
		}

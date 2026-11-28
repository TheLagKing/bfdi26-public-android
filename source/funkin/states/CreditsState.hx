package funkin.states;

import flixel.FlxObject;
import funkin.shaders.WiggleEffect;
import funkin.shaders.WiggleEffect.WiggleEffectType;

class CreditsState extends MusicBeatState
{
	var bg:FlxSprite;
	
	var scrollX:Float = 0;
	var scrollBar:Null<FlxSprite> = null;
	
	var canScroll:Bool = true;

	var credits:FlxTypedGroup<FlxObject>;
	var descriptions:Array<Array<String>> = [
		["Director, Lead Artist, Animator, Voice Actor", "https://x.com/flaskcastle"],
		["Director, Lead Coder, Charter, Composer, Artist, Voice Actor", "https://x.com/Blam_Daylight"],
		["Director, Artist, Animator, Composer, Charter", "https://x.com/AidenDoesStuff1"],
		["Director, Composer, Chromatics \n Xara", "https://x.com/YtSwolfy"],
		["Composer", "https://x.com/Jautrey10"],
		["Artist", "https://x.com/OLLIEE617283"],
		["Artist", "https://x.com/cherryuplol"],
		["Artist, Voice Actor", "https://x.com/mizosis"],
		["Composer, Charter", "https://www.youtube.com/@ezzythecat"],
		["Composer", "https://x.com/ChucksterTL"],
		["Coder", "https://x.com/ivyanimations"],
		["Artist", "https://x.com/Nyantaktt"],
		["Artist", "https://x.com/azuwure_"],
		["Artist, Animator", "https://x.com/percjac0"],
		["Composer", "https://x.com/existnt_k"],
		["Artist, Chromatics", "https://x.com/wrptoonz"],
		["Artist, Composer","https://x.com/heyitsmekayla__"],
		["Coder", "https://x.com/vechettlol"],
		["Composer", "https://x.com/vaderlings"],
		["Composer", "https://x.com/thegabim_"],
		["Artist", "https://x.com/michimoomo"],
		["Artist", "https://x.com/_NinjaMonk_"],
		["Artist, Composer", "https://x.com/hypsk8r"],
		["Chromatics", "https://www.youtube.com/@KrunchyK/"],
		["Artist", "https://x.com/JObjects"],
		["Artist, Animator", "https://x.com/Deroxx12"],
		["Composer", "https://x.com/kobai_kid"],
		["Composer", "https://x.com/Ascenti4"],
		["Charter", "https://x.com/FlootenaDX"],
		["Composer", "https://x.com/Legogodzilla702"],
		["Composer", "https://x.com/VanillaaVani"],
		["Artist, Voice Actor", "https://x.com/dommiexists"],
		["Composer", "https://x.com/koviklutz"],
		["Composer", "https://x.com/spikeish_"],
		["Composer", "https://x.com/funkypoppp"],
		["Composer", "https://x.com/ahhhloof"],
		["Composer", "https://x.com/uncommonblin"],
		["Composer", "https://x.com/EmperorKhanz"],
		["Composer", "https://x.com/jreyb09"],
		["Coder", "https://x.com/Kobalts19"],
		["Composer", "https://x.com/EmperorKhanz"],
		["Composer", "https://x.com/nerdemoji2763"],
		["Composer, Chromatics", "https://youtube.com/@pt_award"],
		["Chromatics, Voice Actor", "BigAndRotund"],
		["Guest Composor on Invitational Dearest Mix", "https://x.com/sp0reshroom"],
		["Legacy Composer", "https://x.com/phynsiclemusic"],
		["Giant Pink\nEvil Leafy...", "https://x.com/CursedPlagueDoc"],
		["Oomf", "https://x.com/mxsterylagoone"],
		["Made the Rocky EXE used in AEWBC", "https://x.com/BlueJack___"],
		["Made the Human Hourglass design used in Webcrasher GF Mix", "https://x.com/LLOR0MANN1C"],
		["Former Charter, Wiki starter", "https://x.com/ColeRocks08"],
		["Started the wiki page", "https://www.youtube.com/@cheesefarmer6139"],
		["Guest 3D modeler and Animator for Aldi + R/BFDIMEMES", "https://x.com/Coolbacon10"],
		["Voice Actor for Strawberry Milk", "https://x.com/slinkyraccoon"],
		["Made the original concept Yoylefake was based on", "https://x.com/bryin64"], 
		["Legacy Composer", "https://x.com/n1ffirg"],
		["Mobile Porter, Coder", "https://www.youtube.com/@thelagkingping999"]
    ];

	var curSelected:Int = -1;
    var frame:CreditFrame;
	var hitbox:FlxObject;

	override function create()
	{
		Paths.clearStoredMemory();
		
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("BFDI 26 - DEVELOPMENT TEAM", null);
		#end
		
		persistentUpdate = true;
		FlxG.camera.bgColor = 0xFF424242;
		FlxG.camera.antialiasing = ClientPrefs.data.antialiasing;
		
		coolwiggle = new WiggleEffect();
		coolwiggle.effectType = WiggleEffectType.DREAMY;
		coolwiggle.waveAmplitude = 0.4;
		coolwiggle.waveFrequency = 2;
		coolwiggle.waveSpeed = 1.5;
		
		scrollBar = new FlxSprite().generateGraphic(250,25);
		scrollBar.screenCenter();
		scrollBar.x -= 235;
		scrollBar.y = FlxG.height - 15;
		scrollBar.alpha = 0;
		FlxTween.tween(scrollBar, {alpha: 1},1, {ease: FlxEase.circOut});
		add(scrollBar);
		scrollBar.scrollFactor.set();
		scrollBar.color = 0xFF686868;
		
		var path = 'menus/credits/VERTICAL CREDITS '
		for (i in 1...FileSystem.readDirectory(path + 'INDIVIDUAL').length + 1)
		{
		    members = new FlxSprite().loadImage(path + 'INDIVIDUAL/split-' + i);
		    members.x = 161 * (i - 1);
	        members.y = 78 * 1;
	        add(members);
	    }

		var title = new FlxSprite().loadImage(path + 'TITLE');
		title.x = FlxG.width / 2 - title.width / 2;
		title.scrollFactor.set();
		title.shader = coolwiggle.shader;
		add(title);

		credits = new FlxTypedGroup<FlxObject>();
        add(credits);

        for (i in 0...descriptions.length)
        {
            var hitbox = new FlxObject((161 * i) + (161 - 156) / 2, 167, 156, 97);
            credits.add(hitbox);
        }

		hitbox = new FlxObject(3, 82, 320, 600);
        add(hitbox);

		FlxG.sound.playMusic(Paths.music('Creditstheme'));
		FlxG.sound.music.volume = 0.8;
		FlxG.camera.zoom += 0.28;
		
		frame = new CreditFrame();
		frame.visible = false;
        add(frame);
		
		super.create();

		#if mobile
		addVirtualPad(NONE, B);
		virtualPad.alpha = 0.3;
		#end	

		Paths.clearUnusedMemory();
	}

	var stop:Bool = false;
	var allowedToUseMouse:Bool = false;
	var usingMouse:Bool = false;
	//var amount:Float = 0.0;
	override function update(elapsed:Float)
	{	
		var justTouched:Bool = false;

		#if mobile
                for (touch in FlxG.touches.list)
	                if (touch.justPressed)
		                justTouched = true;
		#end

		super.update(elapsed);
		
		if (FlxG.mouse.wheel != 0) 
		{
			scrollX += -FlxG.mouse.wheel * 40;
		}
		
		final overlapsBar = FlxG.mouse.overlaps(scrollBar);
		if (overlapsBar) 
		{
			if (!allowedToUseMouse) allowedToUseMouse = true;
		}
		
		if (allowedToUseMouse) 
		{
			if (FlxG.mouse.justPressed) usingMouse = true;
			else if (FlxG.mouse.justReleased) 
			{
				usingMouse = false;
				allowedToUseMouse = false;
			}
			if (usingMouse && FlxG.mouse.deltaViewX != 0) scrollX += FlxG.mouse.deltaViewX * 4.1;
		}
			
		scrollX = Math.max(0, Math.min(scrollX, (usingMouse ? 1600 : 5000)));

		scrollBar.x = FlxMath.lerp(scrollBar.x, scrollX/3.36, 0.10);
		FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, scrollX, 0.07);

		//amount += elapsed * 20;
		//if (amount >= 360) amount = 0;
		//bg.color = FlxColor.fromHSL(amount, 1, 0.5, 1);

		if (controls.BACK && !stop) goodbye();
		coolwiggle.update(elapsed);

		if (mouseOverlapsGroup(credits)) 
		{
            for (i in 0...credits.length) 
			{
                if (curSelected != i && mouseOverlap(credits.members[i])) 
				{
                    curSelected = i;

                    if (descriptions[i] != null) 
					{
                        frame.setText(descriptions[i][0]);
                        if (!frame.visible) frame.visible = true;
                    }
                }
            }

			if (FlxG.mouse.justPressed || justTouched) CoolUtil.browserLoad(descriptions[curSelected][1]);
		} 
		else if (curSelected != -1) 
		{       
            curSelected = -1;
            if (frame.visible) frame.visible = false;
        }

		frame.over = (mouseOverlap(hitbox) ? true : false);
    }

	function goodbye() 
	{
		stop = true;
				
		FlxG.sound.play(Paths.sound('spaceunpause'));
		FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.9},2, {ease: FlxEase.sineInOut});
		
		new FlxTimer().start(0.4,Void -> 
		{
			FlxG.sound.music.fadeOut(0.7);
			FlxG.camera.fade(FlxColor.BLACK, 1, false, function() 
			{
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
				FlxG.switchState(funkin.states.NewMain.new);
			});
		});
	}

	//this is so stupid
	function mouseOverlap(obj:FlxObject = null, ?cam:FlxCamera = null):Bool 
	{
        if (obj == null) return false;
        return ((FlxG.mouse.getScreenPosition(cam).x > obj.x && FlxG.mouse.getScreenPosition(cam).x < obj.x+obj.width) && (FlxG.mouse.getScreenPosition(cam).y > obj.y && FlxG.mouse.getScreenPosition(cam).y < obj.y+obj.height));
    }

	function mouseOverlapsGroup(grp:FlxTypedGroup<Dynamic> = null, ?cam:FlxCamera = null):Bool 
	{
        if (grp == null) return false;

        for (obj in grp.members) 
		{
            if ((FlxG.mouse.getScreenPosition(cam).x > obj.x && FlxG.mouse.getScreenPosition(cam).x < obj.x+obj.width) && (FlxG.mouse.getScreenPosition(cam).y > obj.y && FlxG.mouse.getScreenPosition(cam).y < obj.y+obj.height)) return true;
        }

        return false;
    }
}

class CreditFrame extends FlxSpriteGroup 
{
    public var frameSprite:FlxSprite;
    public var text:FlxText;
	public var over:Bool = false;
	
    public function new() 
	{
        super();
        
        frameSprite = new FlxSprite().makeGraphic(1, 1, 0xFF1F1F1F);
        frameSprite.alpha = 0.5;
        add(frameSprite);

        text = new FlxText(0, 0, 325, "p", 28);
        text.setFormat(Paths.font('YouTubeSansRegular.otf'), 28);
        text.bold = true;
        add(text);

        frameSprite.scale.set(text.frameWidth+2, text.height+2);
        frameSprite.updateHitbox();
    }

    public function setText(t:String = '') 
	{
        text.text = t;
        frameSprite.scale.set(text.frameWidth-10, text.height+2);
		//frameSprite.setGraphicSize((text.textField.textWidth) + 2, (text.textField.textHeight) + 2);
        frameSprite.updateHitbox();
    }

    override function update(elapsed:Float) 
	{
        this.setPosition(FlxG.mouse.getScreenPosition().x + (over ? 20 : -frameSprite.width), FlxG.mouse.getScreenPosition().y);

		super.update(elapsed);
    }
}

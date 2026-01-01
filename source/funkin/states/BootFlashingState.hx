package funkin.states;

import flixel.addons.text.FlxTypeText;

final select:Array<Array<Dynamic>> = 
[
	['Nope.', 415], ['Yup!', 730]
];
var curSel:Int = 0;
    
var opts:FlxTypedGroup<FlxText>;
var selector:FlxText;

var canbruh:Bool = false;

class BootFlashingState extends MusicBeatState //whatever man
{
	var pageNum:Int = 0;
	var logo:FlxSprite;
	var bg:FlxSprite;

	var guy:FlxSprite;
	var guy2:FlxSprite;
	var guy3:FlxSprite;

	var text1:FlxSprite;
	var text2:FlxSprite;

    override function create() 
	{
		FlxG.mouse.visible = false;
		FlxG.camera.bgColor = FlxColor.BLACK;
		FlxG.camera.antialiasing = false;

		logo = new FlxSprite(-325,-175,Paths.image("menus/notice/notice-bg"));
		logo.alpha = 0;
		add(logo);

		text1 = new FlxSprite(-1580,-20,Paths.image("menus/notice/notice text 1"));
		add(text1);

		guy = new FlxSprite(725,25).loadFrames('menus/notice/notice blocky');
		guy.animation.addByPrefix('blocky', 'Symbol 1 instance 1',12);
		guy.animation.play('blocky');
		guy.angle = 0;
		guy.alpha = 0;
		add(guy);

		guy2 = new FlxSprite(1025,100).loadFrames('menus/notice/notice bubs');
		guy2.animation.addByPrefix('bub', 'Symbol 2 instance 1',12);
		guy2.animation.play('bub');
		guy2.angle = 0;
		guy2.alpha = 0;
		add(guy2);

		guy3 = new FlxSprite(250,-150).loadFrames('menus/notice/notice fourest');
		guy3.animation.addByPrefix('est', 'Symbol 9 instance 1');
		guy3.animation.play('est');
		guy3.angle = 0;
		guy3.alpha = 0;
		add(guy3);

		var enter = new FlxSprite(965,885,Paths.image("menus/notice/notice enter"));
		add(enter);

		text2 = new FlxSprite(-581.5,40,Paths.image("menus/notice/notice text 2"));
		add(text2);

		for (i in [logo,text1,guy,guy2,guy3,enter,text2]) i.scale.set(0.675,0.675);

        FlxTween.tween(logo, {alpha: 1}, 2, {ease: FlxEase.quadInOut, startDelay: 1});
        FlxTween.tween(guy, {alpha: 1}, 2, {ease: FlxEase.quadInOut, startDelay: 4});
		FlxTween.tween(guy2, {alpha: 1}, 2, {ease: FlxEase.quadInOut, startDelay: 7});
		FlxTween.tween(text1, {x: -280}, 2.5, {ease: FlxEase.circInOut, startDelay: 3});
		FlxTween.tween(enter, {y: 485}, 2, {ease: FlxEase.circInOut, startDelay: 8, onComplete: Void -> pageNum = 1});
		
        super.create();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.set();
		bg.alpha = 0;
		add(bg);

		//the amount of times this has been copy pasted is kinda funny
		opts = new FlxTypedGroup<FlxText>();
		for (i in 0...select.length)
		{
			var text = new FlxText(0, 0, 0, select[i][0]);
			text.setFormat(Paths.font('flashing.ttf'), 35, (select[i][0] == 'Yup!' ? FlxColor.LIME : FlxColor.RED), LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text.screenCenter();
			text.x += (300 * (i - (select.length / 2))) + 145;
			text.y = 640;
			text.ID = i;
			text.alpha = 0;
			opts.add(text);
		}
		add(opts);

		selector = new FlxText(0, 642, FlxG.width, '>');
		selector.setFormat(Paths.font('flashing.ttf'), 30, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(selector);
		selector.updateHitbox();
		selector.alpha = 0;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
		
		if (controls.ACCEPT) 
		{
			switch (pageNum) 
			{
				case 1:
					pageNum = 0;
					FlxG.sound.play(Paths.sound('enterimpact'));

					for (i in [text1,guy,guy2]) FlxTween.tween(i, {alpha: 0},2, {ease: FlxEase.quadInOut, startDelay: 0.25});
					
					FlxTween.tween(text2, {x: -81.5}, 2.5, {ease: FlxEase.circInOut, startDelay: 2});
					FlxTween.tween(guy3, {alpha: 1}, 2, {ease: FlxEase.quadInOut, startDelay: 4, onComplete:Void -> pageNum = 2});
				case 2:
					pageNum = 0;

					if (funkin.data.Highscore.getSongData('yoylefake',1).songScore > 0)
					{	
						FlxG.sound.play(Paths.sound('enterimpact'));
						FlxTween.tween(FlxG.camera,{zoom: 1.1},0.4,{ease: FlxEase.backOut});

						//copy and pasted from the data reset substate </3

						FlxTween.tween(bg, {alpha: 0.8}, 0.5);

						var text = new FlxText(0,-80,'Watch Out!');
						text.setFormat(Paths.font('flashing.ttf'), 60, FlxColor.RED, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
						text.screenCenter(X);
						add(text);

						FlxTween.tween(text, {y: 60}, 1, {ease: FlxEase.quadOut});

						var warning = new FlxTypeText(0, 190, FlxG.width-200, 
							'It looks like you have previous progress/data from previous updates, which is neat! Always nice to see you come back. But for this update, we recommend you reset your data entirely. However, you are not forced to! That is just our recommendation.\n \n \n \n \n \nDo you want to reset data?');
						warning.setFormat(Paths.font("flashing.ttf"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
						warning.delay = 0.035;
						warning.screenCenter(X);
						add(warning);

						FlxTimer.wait(1.5, () -> warning.start());

						warning.completeCallback = function ()
						{
							for (i in opts) FlxTween.tween(i, {alpha: 1}, 0.6);
							FlxTween.tween(selector, {alpha: 1}, 0.6);
							
							canbruh = true;
							change();
						}
					}
					else okbye();
			}
		}

		if (canbruh) 
		{	
			if (controls.UI_LEFT_P || controls.UI_RIGHT_P) change(controls.UI_LEFT_P ? -1 : 1);
			
			if (controls.ACCEPT)
			{
				canbruh = false;

				if (select[curSel][0] == 'Yup!') 
				{
					FlxG.save.erase();
					FlxG.save.bind('controls_v3', CoolUtil.getSavePath());
					FlxG.save.erase();
				}

				//it resets your data, but it sets modnotice to true ! 
				okbye();
			}
		}
    }

	function change(diff:Int = 0)
	{
		if (diff != 0) FlxG.sound.play(Paths.sound('scrollup1'));
		
		curSel = FlxMath.wrap(curSel + diff, 0, opts.length - 1);

		selector.x = select[curSel][1];
	}

	function okbye() 
	{
		FlxG.sound.play(Paths.sound('enterimpact'));
		FlxG.save.data.modNotice = true;

		FlxG.camera.fade(FlxColor.BLACK, 2, false, function() 
		{
			Main.fpsVar.visible = ClientPrefs.data.showFPS;
			FlxG.switchState(Splash.new);
		});
	}
}
package funkin.states.options;

import flixel.addons.text.FlxTypeText;

class DataReset extends MusicBeatSubstate
{
	final select:Array<Array<Dynamic>> = 
	[
		['Nope.', 415], ['Yup!', 730]
	];
	var curSel:Int = 0;
    
	var opts:FlxTypedGroup<FlxText>;
	var selector:FlxText;

	var cam:FlxCamera;
	var canbruh:Bool = false;
	var canskip:Bool = false;

	var warning:FlxTypeText;

	public function new()
	{
		super();

		@:privateAccess FlxG.camera._fxFadeColor = FlxColor.BLACK;
		FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 0.7},0.5);

		cam = funkin.states.Title.quickCreateCam();
		cam.antialiasing = ClientPrefs.data.antialiasing;
		cameras = [cam];

		var text = new FlxText(0,-80,'Watch Out!');
		text.setFormat(Paths.font('flashing.ttf'), 60, FlxColor.RED, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.screenCenter(X);
		add(text);

		FlxTween.tween(text, {y: 60}, 1, {ease: FlxEase.quadOut});
		
		warning = new FlxTypeText(0, 190, FlxG.width-200, 
			'What you\'re doing is about to reset EVERYTHING!!!! within the game\'s data! That being highscores, secret songs, personalized settings and keybinds, achievements, and so on. If you are unsure whether or not you want to do that, simply select "Nope.". However if you are sure, simply select "Yup!"\n \n \nDo you want to reset data?');
		warning.setFormat(Paths.font("flashing.ttf"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        warning.delay = 0.044;
		warning.screenCenter(X);
		add(warning);

		var warning2 = new FlxTypeText(0, 500, FlxG.width-200, 
			'(Selecting "Yup!" will close the game and you will have to reopen it. Sorry, I\'m too lazy to code that.)');
		warning2.setFormat(Paths.font("flashing.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        warning2.delay = 0.02;
		warning2.alpha = 0.5;
		warning2.screenCenter(X);
		add(warning2);

		var text = new FlxText(FlxG.width - 355, 5, 'You can press SPACE to skip the typing', 20);
		text.font = Paths.font('flashing.ttf');
		text.alpha = 0;
		add(text);

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

		FlxTimer.wait(1.5, () -> 
		{
			FlxTween.tween(text, {alpha: 0.4}, 0.6);
			warning.start();
			canskip = true;
		});

		warning.completeCallback = function () 
		{
			for (i in opts) FlxTween.tween(i, {alpha: 1}, 0.6);
			FlxTween.tween(selector, {alpha: 1}, 0.6);
			FlxTween.tween(text, {alpha: 0}, 0.6);
			
			canbruh = true;
			warning2.start();
		}

		change();
	}

	override public function update(elapsed:Float)
	{
		if (canbruh) 
		{	
			if (controls.UI_LEFT_P || controls.UI_RIGHT_P) change(controls.UI_LEFT_P ? -1 : 1);
			
			if (controls.ACCEPT)
			{
				switch(select[curSel][0]) 
				{
					case 'Yup!':
						FlxG.save.erase();
						FlxG.save.bind('controls_v3', CoolUtil.getSavePath());
						FlxG.save.erase();
							
						FlxG.camera.visible = cam.visible = false;

						FlxTween.tween(FlxG.sound.music, {pitch: 0}, 0.6, {onComplete:Void -> 
						{
							lime.system.System.exit(0);
						}});
							
					case 'Nope.': p();
				}
			}
		}
		
		if (canskip)
		{
			if (FlxG.keys.justPressed.SPACE) 
			{
				warning.skip();
				canskip = false;
			}
		}

		super.update(elapsed);
	}

	function p() 
	{
		FlxTween.tween(cam, {'scroll.y': 30, alpha: 0}, 0.4, {onComplete:Void -> close()});
		FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 0},0.5);
	}

	function change(diff:Int = 0)
	{
		if (diff != 0) FlxG.sound.play(Paths.sound('scrollup1'));
		
		curSel = FlxMath.wrap(curSel + diff, 0, opts.length - 1);

		selector.x = select[curSel][1];
	}
}
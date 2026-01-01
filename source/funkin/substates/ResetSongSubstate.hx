package funkin.substates;

import funkin.data.Highscore;

class ResetSongSubstate extends MusicBeatSubstate
{
	final select:Array<Array<Dynamic>> = 
	[
		['Nope.', 415], ['Yup!', 730]
	];
	var curSel:Int = 0;

    var opts:FlxTypedGroup<FlxText>;
	var selector:FlxText;
	
	var cam:FlxCamera;

	var song:String;
	var pfc:Bool = false;

	public function new(?song:String, ?pfc:Bool = false)
	{
		if (song != null) this.song = song;
		this.pfc = pfc;
		super();
	}

	override function create()
	{
		cam = funkin.states.Title.quickCreateCam();
		cam.antialiasing = ClientPrefs.data.antialiasing;
		cameras = [cam];

		var blackbg = new FlxSprite().generateGraphic(FlxG.width, FlxG.height);
		blackbg.screenCenter();
		blackbg.scrollFactor.set();
		blackbg.color = ClientPrefs.data.lightMode ? FlxColor.WHITE : FlxColor.BLACK;
		blackbg.alpha = 0;
		add(blackbg);

		FlxTween.tween(blackbg, {alpha: 1}, 0.6);

		var test = new FlxSprite().loadImage('menus/freeplay/thumbnails/' + song);
		test.scale.set(0.64,0.64);
		test.x = 50;
		test.y = 70;
		add(test);
		test.updateHitbox();

		var frame = new FlxSprite().loadImage('menus/freeplay/frame');
		frame.scale.set(0.64,0.64);
		frame.x = test.x - 7;
		frame.y = test.y - 11;
		add(frame);
		frame.updateHitbox();

		frame.color = pfc ? 0xFFF4C52C : (ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE);

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
		selector.y = opts.members[0].y;

		var text = new FlxText(430, 200, FlxG.width, 'Do you wish to\nreset data\nfor the song\n${flixel.util.FlxStringUtil.toTitleCase(StringTools.replace(song, "-", " "))} ?');
		text.setFormat(Paths.font('flashing.ttf'), 50, ClientPrefs.data.lightMode ? FlxColor.BLACK : FlxColor.WHITE, CENTER);
		add(text);

		for (i in opts) FlxTween.tween(i, {alpha: 1}, 0.6);
		FlxTween.tween(selector, {alpha: 1}, 0.6);

		super.create();

		change();
	}

	function change(diff:Int = 0)
	{
		if (diff != 0) FlxG.sound.play(Paths.sound('scrollup1'));
		
		curSel = FlxMath.wrap(curSel + diff, 0, opts.length - 1);

		selector.x = select[curSel][1];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK) p();
		if (controls.UI_LEFT_P || controls.UI_RIGHT_P) change(controls.UI_LEFT_P ? -1 : 1);
		if (controls.ACCEPT)
		{
			switch(select[curSel][0]) 
			{
				case 'Yup!':
					var defaultData = Highscore.songScoreDataTemplate();
					Highscore.songScoreDatas.set(song,defaultData);

					FlxG.save.data.songScoreDatas = Highscore.songScoreDatas;
					FlxG.save.flush();
					trace('flushed');

					close();
					
					FlxG.sound.music.pause();
					FlxG.sound.music.stop();

					FlxG.sound.playMusic(Paths.music('freeplayMenu'), 1);
					FlxG.switchState(() -> new funkin.states.FreeplayState(true));
				case 'Nope.': p();
			}
		}
	}

	function p() 
	{
		FlxTween.tween(cam, {alpha: 0.00001},0.5, {onComplete:_->
		{
			close();
		}});
	}
}

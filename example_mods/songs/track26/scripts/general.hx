var shader1 = game.createRuntimeShader("adjustColor");

function onCreate() 
{
	game.camHUD.filters = ([new ShaderFilter(shader1)]);
	game.camGame.filters = ([new ShaderFilter(shader1)]);
}

function onEvent(ev,v1,v2) 
{
	if (ev == 'Trigger')
		var split = v2.split(',');
		var from = (split[0]);
		var to = (split[1]);

		var split2 = v1.split(',');
		var type = (split2[0]);
		var dur = (split2[1]);
	{
		if (type == 's') 
		{
			twn = FlxTween.num(from, to, dur, {ease: FlxEase.quadOut}, s -> shader1.setFloat("saturation", s));
		}
		if (type == 'c') 
		{
			twn2 = FlxTween.num(from, to, dur, {ease: FlxEase.quadOut}, c -> shader1.setFloat("contrast", c));
		}
		if (type == 'b') 
		{
			twn3 = FlxTween.num(from, to, dur, {ease: FlxEase.quadOut}, b -> shader1.setFloat("brightness", b));
		}
		if (type == 'h') 
		{
			twn4 = FlxTween.num(from, to, dur, {ease: FlxEase.quadOut}, h -> shader1.setFloat("hue", h));
		}
	}
}
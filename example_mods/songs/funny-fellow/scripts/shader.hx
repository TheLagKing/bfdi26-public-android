var shader = game.createRuntimeShader("adjustColor");
var shader2 = game.createRuntimeShader("RGB_PIN_SPLIT");

function onCreatePost() game.camGame.filters = ([new ShaderFilter(shader), (new ShaderFilter(shader2))]); game.camHUD.filters = ([new ShaderFilter(shader), (new ShaderFilter(shader2))]);

var twn;
var twn2;
var twn3;

var anim = '';
var anim2 = '';

function opponentNoteHitPre(n) 
n.animSuffix = anim;

function goodNoteHitPre(n) 
n.animSuffix = anim2;

function onEvent(ev,v1,v2) 
{
    if (ev == 'Trigger') 
    {
        if (v1 == 'shaderBop')
        {
        if (twn != null) twn.cancel();
        if (twn2 != null) twn2.cancel();
        if (twn3 != null) twn3.cancel();

        twn = FlxTween.num(50, 0, 2, {ease: FlxEase.quadOut}, f -> shader.setFloat("contrast", f));
        twn2 = FlxTween.num(30, 0, 3, {ease: FlxEase.quadOut}, s -> shader.setFloat("brightness", s));
        twn3 = FlxTween.num(0.01, 0, 1, {ease: FlxEase.quadOut}, t -> shader2.setFloat("amount", t));
        }
        if (v1 == 'animSwitch')
        {
        anim = v2;
        }
        if (v1 == 'animSwitchBF')
        {
        anim2 = v2;
        }
    }
}

function onSongStart() 
{
	var oppPos = [for (i in game.opponentStrums) i.x];
	for (i in 0...4) 
    {
		if (!ClientPrefs.data.opponentStrums) game.opponentStrums.members[i].x = game.playerStrums.members[i].x;
	}

    for (i in opponentStrums) i.x = -1000;
}
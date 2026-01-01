var shader = game.createRuntimeShader("adjustColor");
var shader2 = game.createRuntimeShader("rain");
import funkin.data.Highscore;
import funkin.data.ModSave;

var popCheck = false;
var d:FlxSprite;
function onCreate() 
{
    game.camGame.filters = ([new ShaderFilter(shader), (new ShaderFilter(shader2))]);

if (!ClientPrefs.data.hideCards) 
{
    if (Highscore.getSongData('yoylefake',1).songScore <= 0) 
    {
    d = new FlxSprite().loadGraphic(Paths.image('rendersnlogos/dirtybubblerender'));
    d.y = 300;
    if (ClientPrefs.data.downScroll) d.y = -35;
    d.scale.set(1.5,1.5);
    }

else 
{
    d = new FlxSprite().loadGraphic(Paths.image('rendersnlogos/dirtybubblerender2'));
    d.y = 285;
    if (ClientPrefs.data.downScroll) d.y = -75;
    d.scale.set(0.65, 0.65);
}
    d.x = 1000;
    d.alpha = 0.001;
    d.camera = camHUD;
    d.updateHitbox();
    insert(0,d);
    }
}

function onUpdatePost() 
{
    if (FlxG.mouse.justPressed && (FlxG.mouse.overlaps(dad) && dad.alpha > 0 && popCheck == true)) 
    {
        dad.alpha = 0;
        FlxG.sound.play(Paths.sound('pop'));
        #if DISCORD_ALLOWED DiscordClient.changePresence("BFDI 26 - MAIN MENU", null); #end
        Highscore.saveSongData('yoylefake',1,game.songScore,game.percent,Highscore.calculateFC(game.songMisses,game.percent),game.ratingsData[0].hits,game.ratingsData[1].hits,game.ratingsData[2].hits,game.ratingsData[3].hits);
		ModSave.markSongSeen('yoylefake');
			
		FlxG.switchState(()-> new funkin.states.FreeplayState());

		FlxG.sound.music.pause();
		FlxG.sound.music.stop();
		FlxG.sound.playMusic(Paths.music('freeplayMenu'), 0);
    }
}

function onUpdate() shader2.setFloat("iTime", Conductor.songPosition / 100); 

var twn;
function onEvent(ev,v1,v2) {
if (ev == 'Trigger') {
    if (twn != null) twn.cancel();

if (!ClientPrefs.data.hideCards) 
{
if (v1 == 'renderin') {
FlxTween.tween(d, {alpha: 1, x: 810}, 1.75, {ease: FlxEase.quadOut});
FlxTween.tween(d2, {alpha: 1, x: 810}, 1.75, {ease: FlxEase.quadOut});
}

if (v1 == 'renderout') {
FlxTween.tween(d, {alpha: 0, x: 1000}, 1.75, {ease: FlxEase.quadIn});
FlxTween.tween(d2, {alpha: 0, x: 1000}, 1.75, {ease: FlxEase.quadIn});
}
}

if (v1 == 'trans1') {
    raintwn = FlxTween.num(0, 0.075, 5, {ease: FlxEase.quadIn}, r -> shader2.setFloat("iIntensity", r));
    shader2.setFloat('iTimescale', 0.1);
}

if (v1 == 'eviltrans') {
    twn = FlxTween.num(0, 50, 0.245, {ease: FlxEase.quadOut}, s -> shader.setFloat("saturation", s));
}

if (v1 == 'yoylefake') {
twn.cancel();
    twn = FlxTween.num(50, 0, 0.5, {ease: FlxEase.quadOut}, s -> shader.setFloat("saturation", s));
    raintwn = FlxTween.num(0.075, 0, 1.25, {ease: FlxEase.circOut}, r -> shader2.setFloat("iIntensity", r));
    shader2.setFloat('iTimescale', 0.0);
}

if (v1 == 'blackout') {
twn.cancel();
    twn = FlxTween.num(0, -25, 1.25/4, {ease: FlxEase.circOut}, s -> shader.setFloat("saturation", s));
}

if (v1 == 'blackoutlong') {
twn.cancel();
    twn = FlxTween.num(0, -25, 2.5, {ease: FlxEase.circOut}, s -> shader.setFloat("saturation", s));
}

if (v1 == 'blackoutend') {
twn.cancel();
    twn = FlxTween.num(25, 0, 1.25/2, {ease: FlxEase.circOut}, s -> shader.setFloat("saturation", s));
}

if (v1 == 'blackoutredend' || 'spookytween') {
twn.cancel();
twn = FlxTween.num(25, 0, 1.25, {ease: FlxEase.cubeOut}, s -> shader.setFloat("saturation", s));
}

if (v1 == 'popchecktrue') {
popCheck = true;
}

if (v1 == 'popcheckfalse') {
popCheck = false;
}

}
}
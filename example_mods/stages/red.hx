import flixel.util.FlxGradient;

var bgGradient:FlxSprite;
var shit = false;
var shit2 = false;
function onCreate(){
	camGame.bgColor = 0xFFFFFFFF;

	bgGradient = new FlxSprite();
	bgGradient.loadGraphic(FlxGradient.createGradientBitmapData(2, 400, [0xFF770000, 0xFFFFFFFF], 1, 90));
	bgGradient.scale.set(2000, 2);
	bgGradient.scrollFactor.set(0.85,0.85);
	bgGradient.updateHitbox();
	bgGradient.alpha = 0;
	bgGradient.setPosition(-1000, -1200);
	bgGradient.cameras = [camGame];
	insert(0,bgGradient);
}

function onCreatePost(){
	camHUD.alpha = 0;
}

function onSongStart(){
FlxTween.tween(bgGradient, {alpha: 0.75, y: -45}, (Conductor.crochet / 1000) * 16, {ease: FlxEase.cubeOut});
}

function onSectionHit(){
if (curSection % 4 == 0 && bgGradient.alpha == 0.75 && shit2 == true){
bgGradient.alpha = 1;
FlxTween.tween(bgGradient, {alpha: 0.75}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.quintOut});
boom();
}
}

function boom() {
	if (FlxG.camera.zoom < 1.35 && ClientPrefs.data.camZooms) {
		FlxG.camera.zoom += .015;
		game.camHUD.zoom += .03;
	}
}

function onUpdate(e) {
	var mult:Float = 1 - Math.exp(-e * 7);
	game.camGame.zoom += (game.defaultCamZoom - game.camGame.zoom) * mult;
	game.camHUD.zoom += (1 - game.camHUD.zoom) * mult;
}

function onEvent(ev,v1,v2) {
    if (ev == 'Trigger') {
        if (v1 == 'move') {
    FlxTween.tween(bgGradient, {y: 100, alpha: 0.75}, (Conductor.crochet / 1000) * 4, {ease: FlxEase.elasticOut});
	FlxTween.tween(FlxG.camera, {zoom: 0.75}, (Conductor.crochet / 1000) * 2, {ease: FlxEase.sineOut});
	game.defaultCamZoom = 0.75;
	onFocusZoom = true;
		}
	 if (v1 == 'thing') {
		shit = true;
	 }

	 if (v1 == 'thing2') {
		shit2 = true;
	 }

	}
}

function onMoveCamera(char:String) {
	if (shit == true){
		
	switch (char) {
		case "dad":
	game.defaultCamZoom = 0.725;
		case "boyfriend":
	game.defaultCamZoom = 0.87;
		}
	}
}
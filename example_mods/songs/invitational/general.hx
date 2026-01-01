var shader = game.createRuntimeShader("adjustColor");

function initShaders() {
}

function onCreate() {
game.camGame.filters = ([new ShaderFilter(shader)]);
shader.setFloat('contrast', 20);
shader.setFloat('hue', 15);
shader.setFloat('brightness', -125);
shader.setFloat('saturation', -50);
}

function onEvent(ev,v1,v2) {
if (ev == 'Trigger') {
if (v1 == 'sunriseend') {
twn = FlxTween.num(20, 0, 0.467, {ease: FlxEase.quadOut}, c -> shader.setFloat("contrast", c));
twn2 = FlxTween.num(15, 0, 0.421, {ease: FlxEase.quadOut}, h -> shader.setFloat("hue", h));
twn3 = FlxTween.num(-125, 0, 0.55, {ease: FlxEase.quadOut}, b -> shader.setFloat("brightness", b));
twn4 = FlxTween.num(-50, 0, 0.5, {ease: FlxEase.quadOut}, s -> shader.setFloat("saturation", s));
}
}
}
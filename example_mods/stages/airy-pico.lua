local Cutscene = true

function onStartCountdown()    
    if Cutscene and not seenCutscene then
	runHaxeCode([[po1.delayAndStart();]])
	runTimer('endvideo',27)
    return Function_Stop;
    end
end

function onCreate()
setProperty('bars.alpha',1)
setProperty('textmiss.alpha',1)
setProperty('camGame.bgColor', getColorFromHex('000000'))

-- school
makeLuaSprite('back', 'backgrounds/oneshot/pico-mix/class/backdropCLASSROOM',-700,200)
setScrollFactor('back',0.9875,0.9875)
setProperty('back.alpha',1)
addLuaSprite('back',false)

makeLuaSprite('chairs', 'backgrounds/oneshot/pico-mix/class/schooldeskwradio',1074,1250)
setScrollFactor('chairs',0.99,0.99)
setProperty('chairs.alpha',1)
addLuaSprite('chairs',false)
--

-- outside
makeLuaSprite('sky', 'backgrounds/oneshot/pico-mix/outside/gradient sky',-500,-425)
setScrollFactor('sky',0.1,0.1)
setProperty('sky.alpha',0)
addLuaSprite('sky',false)

makeLuaSprite('parlor', 'backgrounds/oneshot/pico-mix/outside/unloaded bg',200,525)
setScrollFactor('parlor',0.99,0.99)
setProperty('parlor.alpha',0)
addLuaSprite('parlor',false)

makeAnimatedLuaSprite('bus','backgrounds/oneshot/pico-mix/outside/bus passby transition',-4500,850)
scaleObject('bus',0.75,0.75)
addAnimationByPrefix('bus','pass','bus darkened instance 1',24,true)
setScrollFactor('bus',1.05,1.05)
addLuaSprite('bus',true)
-- lane
makeLuaSprite('airybg','backgrounds/oneshot/pico-mix/outside2/burpsquad',-670,400)
setProperty('airybg.alpha',0)
addLuaSprite('airybg',false)

makeLuaSprite('airybg2','backgrounds/oneshot/pico-mix/outside2/MULTIPLY LAYER',0,0)
setObjectCamera('airybg2','camHUD')
setBlendMode('airybg2','multiply')
screenCenter('airybg2','xy')
setProperty('airybg2.alpha',0)
addLuaSprite('airybg2',false)

makeLuaSprite('lightning', '',0,390)
makeGraphic('lightning',1280,720,'FFFFFF')
setProperty('lightning.alpha',0.001)
screenCenter('lightning','x')
scaleObject('lightning',2,2)
addLuaSprite('lightning',false)
--
-- background shit
makeLuaSprite('black', '',-500,750)
makeGraphic('black',1280,720,'000000')
scaleObject('black',2,2)
setProperty('black.visible',false)
addLuaSprite('black',false)

makeLuaSprite('white', '',1500,750)
makeGraphic('white',1280,720,'FFFFFF')
setProperty('white.visible',false)
scaleObject('white',2,2)
addLuaSprite('white',false)

makeLuaSprite('plane', 'backgrounds/oneshot/onecolor',-650,-500)
setScrollFactor('plane',0.99,0.99)
setProperty('plane.alpha',1)
addLuaSprite('plane',false)

makeAnimatedLuaSprite('glow', 'backgrounds/oneshot/oneglow',550,600)
addAnimationByPrefix('glow', 'glows', 'funnyglowythings',24,true)
setScrollFactor('glow',0.85,0.85)
setProperty('glow.alpha',1)
addLuaSprite('glow',false)

createInstance('rainbow', 'flixel.addons.display.FlxBackdrop', {nil, 0x01, 0})
loadGraphic('rainbow', 'backgrounds/oneshot/rainbowloop')
setProperty('rainbow.velocity.x', -300)
setProperty('rainbow.x',1584)
setProperty('rainbow.y',800)
setScrollFactor('rainbow',0.99,0.99)
scaleObject('rainbow',0.3,1)
setProperty('rainbow.alpha',0.03)
addLuaSprite('rainbow',false)

makeLuaSprite('chairs1', 'backgrounds/oneshot/backgroundone',-770,965)
setScrollFactor('chairs1',0.925,0.925)
setProperty('chairs1.alpha',1)
addLuaSprite('chairs1',false)

makeLuaSprite('v', 'backgrounds/oneshot/vignette',0,0)
setProperty('v.alpha',1)
setObjectCamera('v','camHUD')
addLuaSprite('v',true)

makeLuaSprite('r', 'backgrounds/oneshot/overlay',100,0)
setProperty('r.alpha',1)
setObjectCamera('r','camHUD')
setBlendMode('r','lighten')
addLuaSprite('r',false)

makeLuaSprite('fade', '',-1280,0);
makeGraphic('fade',1280,720,'000000')
addLuaSprite('fade',false);
setObjectCamera('fade', 'other')
end

function onCreatePost()
for i = 0,3 do
setPropertyFromGroup('strumLineNotes',i,'alpha',0)
end

if (shadersEnabled) then
initLuaShader("adjustColor");
end
end

function onEvent(name,v1)
if name == 'Trigger' then
if v1 == 'zoomout' then
setProperty('cameraSpeed',1000)
setProperty('camGame.zoom',0.85)
setProperty('defaultCamZoom',0.85)
setProperty('cameraSpeed',1)
for _, backgroundp in ipairs({'plane','glow','rainbow','rainbow2','chairs1','r'}) do
setProperty(backgroundp..'.visible',false)
end
elseif v1 == 'oneshotstart' then
setProperty('white.visible',true)
setProperty('black.visible',true)

setProperty('chairs.alpha',0)
setProperty('back.alpha',0)

if not hideHud then
setProperty('iconP1.visible',false)
setProperty('iconP2.visible',false)
setProperty('healthBar.visible',false)
end

setProperty('camHUD.alpha',1)
setProperty('camGame.alpha',1)
setProperty('boyfriendGroup.x',getProperty('boyfriend.x')-250)
setProperty('boyfriend.color',getColorFromHex('000000'))
runHaxeCode([[
FlxTween.tween(dad.colorTransform, { redOffset: 255, greenOffset: 255, blueOffset: 255, redMultiplier: 0, greenMultiplier: 0, blueMultiplier: 0},0.1);
]])
elseif v1 == 'negative' then
makeGraphic('black',1280,720,'FFFFFF')
makeGraphic('white',1280,720,'000000')

runHaxeCode([[
FlxTween.tween(boyfriend.colorTransform, { redOffset: 255, greenOffset: 255, blueOffset: 255, redMultiplier: 0, greenMultiplier: 0, blueMultiplier: 0},0.1);
]])
runHaxeCode([[
FlxTween.tween(dad.colorTransform, { redOffset: 0, greenOffset: 0, blueOffset: 0, redMultiplier: 0, greenMultiplier: 0, blueMultiplier: 0},0.01);
]])
setProperty('dad.color',getColorFromHex('000000'))
elseif v1 == 'outside' then
for _, backgroundc in ipairs({'chairs','back','v'}) do
setProperty(backgroundc..'.visible',false)
end

setProperty('parlor.alpha',1)
setProperty('sky.alpha',1)

runHaxeCode([[
FlxTween.tween(boyfriend.colorTransform, { redOffset: 0, greenOffset: 0, blueOffset: 0, redMultiplier: 1, greenMultiplier: 1, blueMultiplier: 1},0.01);
]])
setProperty('boyfriendGroup.x',getProperty('boyfriend.x')-100)
setProperty('dadGroup.x',getProperty('dad.x')-100)
setProperty('dad.color',getColorFromHex('FFFFFF'))


setProperty('defaultCamZoom',0.675)
removeLuaSprite('black')
removeLuaSprite('white')

if not hideHud then
setProperty('iconP1.visible',true)
setProperty('iconP2.visible',true)
setProperty('healthBar.visible',true)
end

if shadersEnabled then
setSpriteShader('dad','adjustColor')
setSpriteShader('boyfriend','adjustColor')
setShaderFloat("dad", "brightness",-30)
setShaderFloat("boyfriend", "brightness",-30)
end
elseif v1 == 'bus' then
doTweenX('bus1','bus',-500,0.2)
end
elseif v1 == 'nolightning' then
cancelTimer('lightning')
setProperty('camgame.alpha',0)
end
end

function onUpdatePost()
songPos = getSongPosition()
doTweenAlpha('glows','glow',getProperty('glow.alpha')-0.25*math.sin((songPos/1500) * (bpm/60) *0.75),0.01)
doTweenAlpha('rainbowglow','r',0.75-1*math.sin((songPos/500) * (bpm/60) *1)/5,1)
end

function onTweenCompleted(tag)
if tag == 'bus1' then
doTweenX('bus2','bus',4000,0.2)
setProperty('parlor.alpha',0)
setProperty('sky.alpha',0)
setProperty('v.visible',true)
setProperty('airybg.alpha',1)
setProperty('airybg2.alpha',1)
setProperty('defaultCamZoom',0.75)
setProperty('dadGroup.x',getProperty('dadGroup.x')+20)
setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x')+20)
runTimer('lightning',getRandomInt(10,20))
playSound('lightning',0.05)
if shadersEnabled then
removeSpriteShader('dad')
removeSpriteShader('boyfriend')
end
end
end

function onTimerCompleted(tag)
if tag == 'lightning' and getProperty('camGame.alpha') ~= 0 then
lightning()
runTimer('lightning',getRandomInt(10,20))
elseif tag == 'endvideo' then
runHaxeCode([[po1.destroy();]])
Cutscene = false
startCountdown()
return Function_Continue;
end
end

function lightning()
if getProperty('camGame.alpha') ~= 0 then
playSound('lightning',0.15)
triggerEvent('Screen Shake','1.75,0.001','1.75,0.00025')
setProperty('lightning.alpha',1)
doTweenAlpha('lightninggo','lightning',0,1.75,'sineIn')
setProperty('dadGroup.color',getColorFromHex('000000'))
setProperty('boyfriendGroup.color',getColorFromHex('000000'))
doTweenColor('dadlightning','dadGroup','ffffff',1.75,'sineIn')
doTweenColor('bflightning','boyfriendGroup','ffffff',1.75,'sineIn')
end
end
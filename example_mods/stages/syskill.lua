function onSongStart()
doTweenZoom('camGamehihi2','camGame',getProperty('defaultCamZoom'),15,'cubeInOut')
end

function onCreate()
doTweenZoom('camGamehihi','camGame',2,0.001)
setProperty('isCameraOnForcedPos', true)
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeLuaSprite('bag','backgrounds/syskill/thanosbasicskybox',2150,825)
scaleObject('bag',2.5,2.5)
setScrollFactor('bag',0.7,0.7)
addLuaSprite('bag',false)

makeLuaSprite('back','backgrounds/syskill/Syskill3',2350,850)
scaleObject('back',2,2)
setScrollFactor('back',0.775,0.775)
addLuaSprite('back',false)

makeLuaSprite('floor','backgrounds/syskill/Syskill1',3100,1250)
scaleObject('floor',2,2)
addLuaSprite('floor',false)

makeLuaSprite('fg','backgrounds/syskill/Syskill2',3750,1450)
scaleObject('fg',2,2)
setScrollFactor('fg',1.15,1.15)
addLuaSprite('fg',true)

makeLuaSprite('c', 'rendersnlogos/carrotrender',1250,50)
setProperty('c.alpha',0)
setObjectCamera('c','camHUD')
scaleObject('c',0.85,0.85)
addLuaSprite('c',false)
if not hideCards then
makeAnimatedLuaSprite('logos', 'rendersnlogos/syskillTxt',0,0)
addAnimationByPrefix('logos', 'title', 'syskillTxt',24,true)
setProperty('logos.alpha',0)
scaleObject('logos',1.25,1.25)
setObjectCamera('logos','camHUD')
screenCenter('logos','xy')
addLuaSprite('logos',true)
end

makeLuaSprite('blue', '', 0, 0)
setScrollFactor('blue', 0, 0)
makeGraphic('blue', 3840, 2160, '001EFF')
addLuaSprite('blue', true)
setBlendMode('blue','add')
setProperty('blue.alpha', 0.025)
setObjectCamera('blue','other')
screenCenter('blue', 'xy')

if songName == 'syskill-pico' then
if not hideCards then
makeLuaSprite('logos', 'rendersnlogos/syskillpicomixtitle',0,0)
setProperty('logos.alpha',0)
scaleObject('logos',1,1)
setObjectCamera('logos','camHUD')
screenCenter('logos','xy')
addLuaSprite('logos',true)
end
end
end

function onCreatePost()
setProperty('gf.visible',false)
setProperty('dad.alpha',0)
if shadersEnabled == true and songName == 'syskill-pico' then
loadGraphic('bag','backgrounds/syskill/syskillgradient')
setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x')+100)

for i, object in ipairs({'boyfriend', 'dad'}) do
setSpriteShader(object, 'dropShadow')

setShaderFloat('boyfriend', 'hue', 53)
setShaderFloat('boyfriend', 'saturation', -17)
setShaderFloat('boyfriend', 'contrast', 9)
setShaderFloat('boyfriend', 'brightness', -57)
setShaderFloat('boyfriend', 'ang', math.rad(120))

setShaderFloat('dad', 'hue', -24)
setShaderFloat('dad', 'saturation', -27)
setShaderFloat('dad', 'contrast', 24)
setShaderFloat('dad', 'brightness', -33)
setShaderFloat('dad', 'ang', math.rad(120))

for i, object2 in ipairs({'fg', 'back','floor'}) do
setSpriteShader(object2, 'adjustColor')

setShaderFloat('back', 'hue', 35)
setShaderFloat('back', 'saturation', -21)
setShaderFloat('back', 'contrast', 17)
setShaderFloat('back', 'brightness', -114)

setShaderFloat('floor', 'hue', -10)
setShaderFloat('floor', 'saturation', -26)
setShaderFloat('floor', 'contrast', -11)
setShaderFloat('floor', 'brightness', -64)

setShaderFloat('fg', 'hue', 13)
setShaderFloat('fg', 'saturation', -39)
setShaderFloat('fg', 'contrast', 6)
setShaderFloat('fg', 'brightness', -25)

setShaderFloat(object2, 'str', 1)
setShaderFloat(object2, 'dist', 0)
setShaderFloat(object2, 'thr', 1)
end


--
setShaderFloat(object, 'str', 1)
setShaderFloat(object, 'dist', 10)
setShaderFloat(object, 'thr', 0.1)
setShaderFloat(object, 'AA_STAGES', 2)
setShaderFloatArray(object, 'dropColor', {26 / 255, 44 / 255, 160 / 255})
setShaderFloat('dad','dist',15)
--
end
end
end

function onUpdatePost(elapsed)
if shadersEnabled == true and songName == 'syskill-pico' then
for i, object in ipairs({'boyfriend', 'dad'}) do
setShaderFloatArray(object, 'uFrameBounds', {getProperty(object..'.frame.uv.x'), getProperty(object..'.frame.uv.y'), getProperty(object..'.frame.uv.width'), getProperty(object..'.frame.uv.height')})
setShaderFloat(object, 'angOffset', math.rad(getProperty(object..'.frame.angle')))
end
end
end
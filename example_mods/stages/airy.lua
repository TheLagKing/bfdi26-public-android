local nozooming = false
local glow = true
local subwayArray = {'subbg','subpil','submultiply','sublight','subspot','subspot2','train','radio','spotlight'}
local elight = 8

function onSongStart()
setProperty('isCameraOnForcedPos', true)
setProperty('camFollow.y',1365)
end

function onCreate()
for i = 1,16 do
precacheImage("backgrounds/oneshot/memories/memory"..i.."")
end

setProperty('camGame.alpha',0)
setProperty('camHUD.alpha',0)
setProperty('camZooming',false)
setProperty('camGame.bgColor', getColorFromHex('000000'))

setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)
-- background shit
makeLuaSprite('box','',0,0) -- for tweening character shaders in lua dont kill me
setProperty('box.alpha',0)
addLuaSprite('box')
--

-- b&w
makeLuaSprite('inverts', 'backgrounds/oneshot/Invert-BW',575,700)
setProperty('inverts.alpha',1)
addLuaSprite('inverts',false)

makeLuaSprite('Attente', 'backgrounds/oneshot/Attente BW',1000,1000)
setScrollFactor('Attente',0.925,0.925)
setProperty('Attente.alpha',1)
addLuaSprite('Attente',false)
--

-- viewer WR
makeLuaSprite('tsky','backgrounds/oneshot/ourwaiting/player hell sky',0,1000)
setScrollFactor('tsky',0.25,0.25)
setProperty('tsky.alpha',0.001)
screenCenter('tsky','xy')
setProperty('tsky.x',getProperty('tsky.x')+200)
addLuaSprite('tsky')

makeLuaSprite('tsun','backgrounds/oneshot/ourwaiting/player hell star',0,1000)
setScrollFactor('tsun',0.25,0.25)
screenCenter('tsun','x')
setProperty('tsun.x',getProperty('tsun.x')+200)
setProperty('tsun.alpha',0.001)
addLuaSprite('tsun',false)

makeLuaSprite('tg','backgrounds/oneshot/ourwaiting/player hell behind',-850,-875)
setScrollFactor('tg',0.6,0.6)
setProperty('tg.alpha',0.001)
addLuaSprite('tg',false)

makeLuaSprite('ts','backgrounds/oneshot/ourwaiting/speaker pillar',2100,1350)
setScrollFactor('ts',0.7,0.7)
setProperty('ts.alpha',0.001)
addLuaSprite('ts')

makeLuaSprite('tsp','backgrounds/oneshot/ourwaiting/sour apple pillar',-100,1350)
setScrollFactor('tsp',0.7,0.7)
setProperty('tsp.alpha',0.001)
addLuaSprite('tsp')

makeLuaSprite('te','backgrounds/oneshot/ourwaiting/evan pillar',1500,1350)
setScrollFactor('te',0.675,0.675)
setProperty('te.alpha',0.001)
addLuaSprite('te')

makeLuaSprite('tf','backgrounds/oneshot/ourwaiting/player hell ground',-650,1150)
setProperty('tf.alpha',0.001)
addLuaSprite('tf',false)
--


-- WR
makeLuaSprite('plane', 'backgrounds/oneshot/onecolor',-650,-500)
setScrollFactor('plane',0.99,0.99)
setProperty('plane.alpha',0.001)
addLuaSprite('plane',false)

makeAnimatedLuaSprite('glow', 'backgrounds/oneshot/oneglow',550,600)
addAnimationByPrefix('glow', 'glows', 'funnyglowythings',24,true)
setScrollFactor('glow',0.85,0.85)
setProperty('glow.visible',false)
addLuaSprite('glow',false)

createInstance('rainbow', 'flixel.addons.display.FlxBackdrop', {nil, 0x01, 0})
loadGraphic('rainbow', 'backgrounds/oneshot/rainbowloop')
setProperty('rainbow.velocity.x', -300)
setProperty('rainbow.x',1584)
setProperty('rainbow.y',900)
setScrollFactor('rainbow',0.99,0.99)
scaleObject('rainbow',0.3,1)
setProperty('rainbow.alpha',0.001)
addLuaSprite('rainbow',false)

makeLuaSprite('chairs', 'backgrounds/oneshot/backgroundone',-770,965)
setScrollFactor('chairs',0.925,0.925)
setProperty('chairs.alpha',0.001)
addLuaSprite('chairs',false)

makeLuaSprite('v', 'backgrounds/oneshot/vignette',0,0)
setProperty('v.alpha',0.001)
setObjectCamera('v','camHUD')
addLuaSprite('v',true)

makeLuaSprite('r', 'backgrounds/oneshot/overlay',100,0)
setProperty('r.visible',false)
setObjectCamera('r','camHUD')
setBlendMode('r','lighten')
addLuaSprite('r',false)
--

makeLuaSprite('black', '', 0, 0)
setScrollFactor('black', 0, 0)
makeGraphic('black',1280,720,'000000')
setProperty('black.alpha',0)
scaleObject('black',3,3)
addLuaSprite('black',false)
screenCenter('black', 'xy')
setObjectOrder('black',getObjectOrder('dadGroup')-1)

if not hideCards then
makeLuaSprite('cred', 'rendersnlogos/Credits BW',275,0)
setObjectCamera('cred','camHUD')
addLuaSprite('cred',true)

makeLuaSprite('logos', 'rendersnlogos/Titlecard BW',0,0)
setProperty('logos.alpha',0)
scaleObject('logos',0.5,0.5)
setObjectCamera('logos','camHUD')
screenCenter('logos','xy')
addLuaSprite('logos',true)
end

-- memory
makeLuaSprite('memory','backgrounds/oneshot/memories/memory1',0,0)
scaleObject('memory',0.675,0.675)
setObjectCamera('memory','camHUD')
setProperty('memory.alpha',0.001)
screenCenter('memory','xy')
addLuaSprite('memory',true)

makeAnimatedLuaSprite('evanm','backgrounds/oneshot/memories/Evan Visage',0,575)
addAnimationByPrefix('evanm','evan','Evan Memory Visage instance 1',24,true)
setObjectCamera('evanm','camHUD')
scaleObject('evanm',0.7,0.7)
setProperty('evanm.visible',false)
setProperty('eyes.alpha',0.001)
screenCenter('evanm','x')
addLuaSprite('evanm',true)

makeLuaSprite('eyes','backgrounds/oneshot/memories/Real Eyes Realize Real Lies',0,775)
setObjectCamera('eyes','camHUD')
scaleObject('eyes',0.7,0.7)
setProperty('eyes.alpha',0.001)
screenCenter('eyes','x')
addLuaSprite('eyes',true)
--
--SUBWAY - hungruy
makeLuaSprite('subbg','backgrounds/oneshot/bg2/subway bg',-700,375)
addLuaSprite('subbg',false)

makeLuaSprite('radio','backgrounds/oneshot/bg2/radio standalone',1425,1525)
addLuaSprite('radio',false)

makeAnimatedLuaSprite('spotlight','backgrounds/oneshot/bg2/Spotlight Walk',2000,1020)
addAnimationByPrefix('spotlight','walk','spotlight walk away instance 1',24,true)
addLuaSprite('spotlight',false)

makeLuaSprite('subspot','backgrounds/oneshot/bg2/subway light',500,200)
setBlendMode('subspot','add')
addLuaSprite('subspot',true)

makeLuaSprite('subspot2','backgrounds/oneshot/bg2/subway light',1750,200)
setBlendMode('subspot2','add')
addLuaSprite('subspot2',true)

makeLuaSprite('subpil','backgrounds/oneshot/bg2/pillars front',400,375)
setScrollFactor('subpil',1.05,1.05)
addLuaSprite('subpil',true)

makeLuaSprite('train','backgrounds/oneshot/bg2/subway car full',-4000,625)
addLuaSprite('train',true)

makeLuaSprite('submultiply','backgrounds/oneshot/bg2/multiply ceiling shade',-400,325)
setBlendMode('submultiply','multiply')
addLuaSprite('submultiply',true)

makeLuaSprite('sublight', '', 0, 0)
setScrollFactor('sublight', 0, 0)
makeGraphic('sublight',1280,720,'222213')
setBlendMode('sublight','subtract')
setProperty('sublight.alpha',0)
scaleObject('sublight',2,2)
setObjectCamera('sublight','camOther')
addLuaSprite('sublight',false)
screenCenter('sublight', 'xy')

for i = 1,#subwayArray do
setProperty(subwayArray[i]..'.alpha',0.01)
end
--
end

function onCreatePost()
setBlendMode('boyfriend','subtract')
setBlendMode('Attente','subtract')

    if shadersEnabled then
        setSpriteShader('evanm','blur')
        setShaderFloat('evanm','directions',30.0)
        setShaderFloat('evanm','quality',10.0)
        setShaderFloat('evanm','merge',1.0)
        setShaderFloat('evanm', "size",3.5);
        setShaderFloat('evanm','alpha',0.35)
	end
end


function onUpdatePost(elapsed)
if shadersEnabled == true then
for i, object in ipairs({'boyfriend', 'dad'}) do
setShaderFloatArray(object, 'uFrameBounds', {getProperty(object..'.frame.uv.x'), getProperty(object..'.frame.uv.y'), getProperty(object..'.frame.uv.width'), getProperty(object..'.frame.uv.height')})
setShaderFloat(object, 'angOffset', math.rad(getProperty(object..'.frame.angle')))
setShaderFloat(object, 'brightness',getProperty('box.x'))
setShaderFloat('boyfriend', 'dist',getProperty('box.y'))
setShaderFloat('dad', 'dist',getProperty('box.y')*1.25)
setShaderFloat('evanm', 'alpha',getProperty('box.y'))
end
end

doTweenAlpha('glows','glow',getProperty('glow.alpha')-0.25*math.sin((getSongPosition()/1500) * (bpm/60) *0.75),0.01)

if nozooming == true then
setProperty('camZooming',false)
end

if glow == true then
doTweenAlpha('rainbowglow','r',0.95-1*math.sin((getSongPosition()/500) * (bpm/60) *1)/5,1)
end
end

function onEvent(name,v1,v2)
if name == 'Trigger' and v1 == 'phantom' then
setProperty('camOther.alpha',0)
setProperty('bfPhantom.visible',false)
setProperty('dadPhantom.visible',false)
elseif name == 'Trigger' and v1 == 'normal' then
setProperty('glow.alpha',0)
setProperty('glow.visible',true)
setBlendMode('boyfriend','')

removeLuaSprite('cred')
removeLuaSprite('Attente')
removeLuaSprite('inverts')

setProperty('v.alpha',1)
setProperty('rainbow.alpha',0.02)
setProperty('chairs.alpha',1)
setProperty('r.visible',true)
setProperty('plane.alpha',1)
elseif name == 'Trigger' and v1 == 'tweenout' then
nozooming = true
doTweenZoom('zoomout','camGame',0.35,22.5,'sineIn')
elseif name == 'Trigger' and v1 == 'credit' then
doTweenX('creds','cred',0,1.5,'circOut')
elseif name == 'Trigger' and v1 == 'title' then
doTweenAlpha('alphalogo','logos',1,2.5,'sineOut')
doTweenX('scalelogox','logos.scale',1,10,'sineOut')
doTweenY('scalelogoy','logos.scale',1,10,'sineOut')
elseif name == 'Trigger' and v1 == 'trans' then
glow = false
cancelTween('rainbowglow')
doTweenAlpha('dier','r',0,2.25,'quadOut')
doTweenAlpha('blackin','black',1,2.25,'quadOut')
elseif name == 'Trigger' and v1 == 'hell' then
cancelTween('zoomout')
cancelTween('blackin')
doTweenY('pillar1','ts',100,8,'circOut')
triggerEvent('Screen Shake','6.5,0.001','6.5,0.00025')
doTweenAlpha('byeblack','black',0,2,'cubeOut')
doTweenY('suncomein','tsun',-250,10,'circOut')
doTweenAlpha('byev','v',0,1,'cubeOut')
removeLuaSprite('plane')
removeLuaSprite('chairs')
removeLuaSprite('rainbow')
setProperty('rainbow.visible',false)
removeLuaSprite('glow')
removeLuaSprite('r')
setProperty('tsky.alpha',1)
setProperty('tsun.alpha',1)
setProperty('tg.alpha',1)
setProperty('tf.alpha',1)
setProperty('ts.alpha',1)
setProperty('tsp.alpha',1)
setProperty('te.alpha',1)
setProperty('defaultCamZoom',0.35)
setProperty('camFollow.y',1165)
removeSpriteShader('dadPhantom')
removeLuaSprite('dadPhantom')
if shadersEnabled then
for i, object in ipairs({'boyfriend','dad'}) do
setSpriteShader(object,'dropshadow')

startTween('cool1', 'box', {x = -45}, 13,{startDelay = 3, ease = 'circOut'})
startTween('cool2', 'box', {y = 17.5}, 13,{startDelay = 2.6, ease = 'circOut'})

setShaderFloat(object, 'hue', 0)
setShaderFloat(object, 'saturation',0)
setShaderFloat(object, 'contrast',0)
setShaderFloat(object, 'ang', math.rad(120))

setShaderFloat(object, 'str', 1)
setShaderFloat(object, 'thr', 0.16)
setShaderFloat(object, 'AA_STAGES', 2)
setShaderFloatArray(object, 'dropColor', {255 / 255, 255 / 255, 255 / 255})

setShaderFloat('dad', 'thr', 0.25)
setShaderFloat('dad', 'ang', math.rad(0))
setShaderSampler2D('dad', 'altMask', 'characters/oneshot/airy EXPLAIN_mask')
setShaderFloat('dad', 'thr2', 0.3)
	setShaderBool('dad', 'useMask', true)
end
else
doTweenColor('ting','dad','b0b0b0',11.25,'sineOut')
doTweenColor('ting2','boyfriend','b0b0b0',11.25,'sineOut')
end

elseif name == 'Trigger' and v1 == 'pillar2' then
doTweenY('pillar2','tsp',150,8,'circOut')
triggerEvent('Screen Shake','6.5,0.001','6.5,0.00025')
elseif name == 'Trigger' and v1 == 'pillar3' then
doTweenY('pillar3','te',250,8,'circOut')
triggerEvent('Screen Shake','6.5,0.001','6.5,0.00025')
elseif name == 'Trigger' and v1 == 'in' then
setProperty('camZooming',false)
doTweenZoom('zoomin','camGame',3,10,'cubeInOut')
setObjectCamera('black','camOther')
screenCenter('black','xy')
doTweenAlpha('blackcomein','black',1,5,'sineIn')
doTweenAlpha('camHUDdes','camHUD',0,5.25,'sineOut')
for i= 4,7 do
noteTweenAlpha('notesdie'..i..'',i,0,4.25,'sineOut')
end
elseif name == 'Trigger' and v1 == 'memorystart' then
if shadersEnabled then
removeSpriteShader('dad')
removeSpriteShader('boyfriend')
end
setProperty('camZooming',true)
setProperty('memory.alpha',1)
setObjectCamera('black','camHUD')
setProperty('camHUD.alpha',1)
setProperty('evanm.visible',true)
setProperty('evanm.alpha',0)
doTweenY('evanomein','evanm',75,22,'circOut')
doTweenY('evanomein2','eyes',275,22,'circOut')
doTweenAlpha('evancomein','evanm',0.2,10.5,'circIn')

if getProperty('cpuControlled') == true then
setProperty('botplayTxt.visible',false)
end

if not hideHud then
for _, hudout in ipairs({'iconP1','bars','textmiss','scoreTxt','textacc','healthBar','iconP2'}) do
setProperty(hudout..'.alpha',0)
end
end

elseif name == 'Trigger' and v1 == 'panic' then
setProperty('camZooming',false)
nozooming = true
doTweenZoom('coolzoom','camGame',1.25,7.753,'cubeIn')
setProperty('defaultCamZoom',1.25)
doTweenY('coolzoom2','camFollow',1515,7.05,'cubeInOut')
doTweenX('coolzoom3','camFollow',getProperty('camFollow.x')+345,7.65,'cubeInOut')
doTweenAlpha('vscary','v',1,5)
elseif name == 'Trigger' and v1 == 'memoryload' then
setProperty('camZooming',false)
loadGraphic('memory','backgrounds/oneshot/memories/memory'..v2..'')
cancelTween('memorycolorthing')
setProperty('memory.color',getColorFromHex('bfbfbf'))
doTweenColor('memorycolorthing','memory','ffffff',2.5,'sineOut')
elseif name == 'Trigger' and v1 == 'noteslive' then
for i= 4,7 do
noteTweenAlpha('noteslive'..i..'',i,1,2.5,'sineOut')
end
elseif name == 'Trigger' and v1 == 'memend' then
removeSpriteShader('evanm')
setProperty('eyes.alpha',1)
setProperty('evanm.alpha',1)
elseif name == 'Trigger' and v1 == 'subway' then
-- i shouldve used arrays dont kill me (again)
removeLuaSprite('tsky')
removeLuaSprite('tsun')
removeLuaSprite('te')
removeLuaSprite('ts')
removeLuaSprite('tsp')
removeLuaSprite('tf')
removeLuaSprite('tg')
removeLuaSprite('black')
setProperty('spotlight.visible',false)
removeLuaScript('songs/oneshot/oneshotReflection')
removeSpriteShader('bfPhantom')
removeLuaSprite('bfPhantom')
setProperty('camFollow.y',1265)
setProperty('defaultCamZoom',0.35)

runTimer('flicker1',getRandomInt(1.6,8))
runTimer('flicker3',getRandomInt(1.6,8))

setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x')+35)
setProperty('dadGroup.x',getProperty('dadGroup.x')-45)

for i = 1,#subwayArray do
setProperty(subwayArray[i]..'.alpha',1)
end

if getProperty('cpuControlled') == true then
setProperty('botplayTxt.visible',true)
end

doTweenX('traingoby1','train',4000,1.25)

if not hideHud then
for _, hudout in ipairs({'iconP1','bars','textmiss','scoreTxt','textacc','healthBar','iconP2'}) do
setProperty(hudout..'.alpha',1)
end
end

elseif name == 'Trigger' and v1 == 'evanin' then
removeLuaSprite('memory')
removeLuaSprite('evanm')
removeLuaSprite('eyes')
elseif name == 'Trigger' and v1 == 'trueend' then
setProperty('train.x',-8000)
doTweenX('traingoby2','train',4000,0.375)
runTimer('end',0.24)
elseif name == 'Trigger' and v1 == 'light' then
elight = v2
elseif name == 'Trigger' and v1 == 'huddie' then
for i= 4,7 do
noteTweenAlpha('notesdiereal'..i..'',i,0,1.5,'sineOut')
end
doTweenAlpha('link','strumbg',0,1.25,'sineOut')
setProperty('botplayTxt.visible',false)
if not hideHud then
for _, hudout in ipairs({'iconP1','textmiss','scoreTxt','textacc','healthBar','iconP2'}) do
setProperty('timeBar.visible',false)
doTweenAlpha(hudout..'notes',hudout,0,1.25,'sineOut')
end
end
end
end

function onTweenCompleted(name)
if name == 'alphalogo' then
doTweenAlpha('alphalogo2','logos',0,1.25)
end
end

function onTimerCompleted(tag)
if tag == 'flicker1' then
setProperty('subspot.color',getColorFromHex('4a4835'))
runTimer('flicker2',getRandomInt(0.4,0.9))
elseif tag == 'flicker2' then
setProperty('subspot.color',getColorFromHex('ffffff'))
runTimer('flicker1',getRandomInt(1.2,8))
elseif tag == 'flicker3' then
setProperty('subspot2.color',getColorFromHex('4a4835'))
runTimer('flicker4',getRandomInt(0.4,0.9))
elseif tag == 'flicker4' then
setProperty('subspot2.color',getColorFromHex('ffffff'))
runTimer('flicker3',getRandomInt(1.2,elight))
elseif tag == 'end' then
setProperty('dadGroup.visible',false)
setProperty('radio.visible',false)
setProperty('subspot.visible',false)
setProperty('subspot2.visible',false)
setProperty('spotlight.visible',true)
makeGraphic('sublight',1280,720,'3E3E23')
doTweenX('spotlightthing','spotlight',3000,10)
end
end
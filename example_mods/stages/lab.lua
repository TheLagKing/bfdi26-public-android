bfy = getProperty('boyfriendGroup.y')
dady = getProperty('dadGroup.y')

function onCreate()
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)
setProperty('camGame.alpha',1)
setBlendMode('strumbg','')
setProperty('camGame.bgColor', getColorFromHex('000000'))
-- background shit
makeLuaSprite('lab2','backgrounds/wrongfinger/right/BG splice/labbe splice',465,25)
addLuaSprite('lab2')
setProperty('lab2.alpha',0)

makeLuaSprite('lab','backgrounds/wrongfinger/right/labbe',0,0)
addLuaSprite('lab')

makeLuaSprite('chair','backgrounds/wrongfinger/right/BG splice/chair sized',2175,640)
addLuaSprite('chair')
setProperty('chair.alpha',0)

createInstance('GB', 'funkin.objects.Character', {600, 292, 'gbright1', false})
addInstance('GB')
playAnim('GB','idle')
setProperty('GB.alpha',0)

createInstance('GB2', 'funkin.objects.Character', {2200, 400, 'gbright2', false})
addInstance('GB2')
scaleObject('GB2',1.7,1.7)
setProperty('GB2.alpha',0)

makeLuaSprite('wire','backgrounds/wrongfinger/right/fg wire 1',350,25)
addLuaSprite('wire',true)
setScrollFactor('wire',1.2,1.2)

makeLuaSprite('wire2','backgrounds/wrongfinger/right/fg wire 2',1250,30)
addLuaSprite('wire2',true)
setScrollFactor('wire2',1.25,1.25)

makeLuaSprite('wire3','backgrounds/wrongfinger/right/fg wire 3',2100,25)
addLuaSprite('wire3',true)
setScrollFactor('wire3',1.15,1.15)

makeLuaSprite('overlay','backgrounds/wrongfinger/right/big ol graddie',-55,-25)
addLuaSprite('overlay',true)
setBlendMode('overlay','overlay')

makeLuaSprite('overlay2','backgrounds/wrongfinger/right/greenie graddie',1000,-100)
addLuaSprite('overlay2',true)
setBlendMode('overlay2','overlay')

makeLuaSprite('overlay3','backgrounds/wrongfinger/right/BG splice/big ol graddie splace',465,25)
addLuaSprite('overlay3',true)
setBlendMode('overlay3','overlay')
setProperty('overlay3.alpha',0)

makeLuaSprite('overlay4','backgrounds/wrongfinger/right/BG splice/greennie graddie splice',750,0)
addLuaSprite('overlay4',true)
setProperty('overlay4.alpha',0)
setBlendMode('overlay4','overlay')

makeLuaSprite('transition','backgrounds/wrongfinger/right/blur pan lab',-4600,0)
setObjectCamera('transition','camHUD')
screenCenter('transition','y')
addLuaSprite('transition')

if not hideCards then
makeLuaSprite('logos','rendersnlogos/wight_ringer_titlecard',0,0)
setObjectCamera('logos','camHUD')
scaleObject('logos',0,0)
screenCenter('logos','xy')
addLuaSprite('logos')
end
end

function onEvent(n,v1,v2)
if n == 'Trigger' then
if v1 == 'pov' then
doTweenX('transstart','transition',-1600,0.25)
setProperty('isCameraOnForcedPos', true)
setProperty('cameraSpeed',100)
setProperty('defaultCamZoom',1.025)

if not middlescroll then
for p= 4,7 do
noteTweenX('movePlayer'..p, p,445 + (110 *(p - 4)), 0.25,'cubeInOut')
end

for p= 0,3 do
noteTweenX('moveOpponent'..p, p,-850 + (115 *(p - 4)), 0.5,'cubeInOut')
end
end
elseif v1 == 'pov2' then
setProperty('cameraSpeed',100)
setProperty('defaultCamZoom',0.75)
setProperty('transition.x',-4600)
doTweenX('transstart2','transition',-1600,0.25)
elseif v1 == 'renderin' then
startTween('cool', 'logos.scale', {x = 0.75, y = 0.75}, 1.75,{startDelay = 0.25, ease = 'quartOut'})
elseif v1 == 'renderout' then
startTween('cool2', 'logos.scale', {x = 0, y = 0}, 1.25,{startDelay = 1, ease = 'quintIn'})
elseif v1 == 'coolbop' then
setProperty('lab.alpha',1)
cancelTween('labcomeback')
doTweenAlpha('labcomeback','lab',0.5,1.25,'circOut')
triggerEvent('Add Camera Zoom','','')
end
end
end

function onTweenCompleted(tag)
if tag == 'transstart' then
setProperty('camFollow.y',550)
setProperty('camFollow.x',1370)  
runTimer('endthing',0.1)
setProperty('boyfriendGroup.y',450)
setProperty('dadGroup.y',450)
setProperty('dadGroup.x',769)
doTweenX('transend','transition',3600,0.25)
for _, hudout in ipairs({'lab','wire','wire2','wire3','overlay','overlay2','gf'}) do setProperty(hudout..'.alpha',0) end
setProperty('overlay3.alpha',1)
setProperty('overlay4.alpha',1)
setProperty('lab2.alpha',1)
setProperty('GB2.alpha',1)
setProperty('chair.alpha',1)
doTweenX('GB2swing','GB2',getProperty('GB2.x')-275,1.75,'cubeOut')
doTweenX('GB2swingchaier','chair',getProperty('chair.x')-275,1.75,'cubeOut')
playAnim('GB2','idle')
elseif tag == 'transstart2' then
setProperty('camFollow.y',0)
setProperty('camFollow.x',0)  
runTimer('endthing',0.1)
doTweenX('transend','transition',3600,0.25)
for _, hudout in ipairs({'lab','wire','wire2','wire3','overlay','overlay2','gf','GB'}) do setProperty(hudout..'.alpha',1) end
setProperty('overlay3.alpha',0)
setProperty('overlay4.alpha',0)
setProperty('GB2.alpha',0)
cancelTween('GB2swing')
cancelTween('GB2swingchaier')
setProperty('lab2.alpha',0)
setProperty('isCameraOnForcedPos', false)
setProperty('boyfriendGroup.y',bfy)
setProperty('dadGroup.y',dady)

alreadySwapped = true
if not middlescroll then
for i = 0, 3 do
j = (i + 4)

iPos = _G['defaultPlayerStrumX'..i];
jPos = _G['defaultOpponentStrumX'..i];
if alreadySwapped then
iPos = _G['defaultOpponentStrumX'..i];
jPos = _G['defaultPlayerStrumX'..i];
end
noteTweenX('note'..i..'TwnX', i, iPos, 0.25, 'cubeInOut');
noteTweenX('note'..j..'TwnX', j, jPos, 0.25, 'cubeInOut');
end
end

setProperty('chair.x',600)
setProperty('chair.y',605)

elseif tag == 'GB2swing' then
doTweenX('GB2swing','GB2',getProperty('GB2.x')-275,1.75,'cubeOut')
doTweenX('GB2swingchaier','chair',getProperty('chair.x')-275,1.75,'cubeOut')
end
end

function onTimerCompleted(tag)
if tag == 'endthing' then
setProperty('cameraSpeed',1)
end
end

function onBeatHit()
if curBeat % 2 == 0 then
playAnim('GB','idle')
end
end
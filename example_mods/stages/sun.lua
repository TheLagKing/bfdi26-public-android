function onSongStart()
doTweenAlpha('logoshit','logos',1,3.25,'quadOut')
end


function onCreate()
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)
setProperty('camZooming',true)
setObjectCamera('bars','other')
-- background shit

makeLuaSprite('bg5', 'backgrounds/hello-operator/bg2/bg2WALL',-115,560)
setProperty('bg5.alpha',1)
addLuaSprite('bg5',false)

makeLuaSprite('bg6', 'backgrounds/hello-operator/bg2/bg2DOORnSIGN',815,750)
setProperty('bg6.alpha',1)
addLuaSprite('bg6',false)

makeLuaSprite('bg4', 'backgrounds/hello-operator/bg2/bg2FLOOR',-115,1200)
setProperty('bg4.alpha',1)
addLuaSprite('bg4',false)

makeLuaSprite('bg7', 'backgrounds/hello-operator/bg2/bg2RAILING',-52.5,1400)
setProperty('bg7.alpha',0.25)
addLuaSprite('bg7',true)

createInstance('bg8', 'flixel.addons.display.FlxBackdrop', {nil, 0x01, 0})
loadGraphic('bg8', 'backgrounds/hello-operator/bg/colors')
setProperty('bg8.velocity.x', -200)
setProperty('bg8.x',-200)
setProperty('bg8.y',450)
setProperty('bg8.alpha',0)
scaleObject('bg8',2,2)
setScrollFactor('bg8',0.95,0.95)
addLuaSprite('bg8',false)

makeLuaSprite('bg1', 'backgrounds/hello-operator/bg/lotsBG',-500,250)
setProperty('bg1.alpha',0)
addLuaSprite('bg1',false)

makeLuaSprite('bg2', 'backgrounds/hello-operator/bg/lotsCHAIR',115,160)
setProperty('bg2.alpha',0)
addLuaSprite('bg2',false)

makeLuaSprite('bg3', 'backgrounds/hello-operator/bg/lotsTABLE',1230,1380)
setProperty('bg3.alpha',0)
addLuaSprite('bg3',true)

makeLuaSprite('vig','backgrounds/hello-operator/bg2/bg2FLITER on add',0,0)
setProperty('vig.alpha',0)
setObjectCamera('vig','camHUD')
setBlendMode('vig','add')
addLuaSprite('vig',false)
if not hideCards then
makeAnimatedLuaSprite('logos', 'rendersnlogos/LOTS',0,0)
addAnimationByPrefix('logos', 'title', 'Symbol 3',24,true)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','camOther')
addLuaSprite('logos',true)
end
end

function onCreatePost()

setProperty('camHUD.visible',false)
setProperty('dad.visible',false)
setProperty('boyfriend.visible',false)
for i = 0, 3 do
j = (i + 4)

iPos = _G['defaultPlayerStrumX'..i];
jPos = _G['defaultOpponentStrumX'..i];
if alreadySwapped then
iPos = _G['defaultOpponentStrumX'..i];
jPos = _G['defaultPlayerStrumX'..i];
end
noteTweenX('note'..i..'TwnX', i, iPos, 1.25, 'cubeOut');
noteTweenX('note'..j..'TwnX', j, jPos, 1.25, 'cubeOut');
if middlescroll == true then
noteTweenX('note'..i..'TwnX',j,iPos, 1.25, 'cubeOut');
noteTweenX('note'..j..'TwnX',i,jPos, 1.25, 'cubeOut');
end
end
end

function onUpdatePost()
    setProperty('iconP1.x',250)
    setProperty('iconP2.x',850)
    setProperty('iconP2.flipX',true)
	setProperty('iconP1.flipX',true)
    setProperty('healthBar.flipX',true)
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'zoomin' then
setProperty('camZooming',false)
doTweenZoom('camGamesht','camGame',4.55,2.48,'cubeInOut')
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenAlpha('logoshit2','logos',0,3.25,'quadOut')
elseif name == 'Trigger' and v1 == 'zoomout' then
doTweenZoom('camGamesht2','camGame',0.65,1.25,'cubeOut')
setProperty('defaultCamZoom',0.65)
setProperty('camZooming',true)
setObjectCamera('bars','camHUD')
setProperty('camHUD.visible',true)
for i = 4,7 do
setProperty('bg'..i..'.alpha',0)
setProperty('bg'..(i-3)..'.alpha',1)
setProperty('dad.visible',true)
setProperty('boyfriend.visible',true)
setProperty('cameraSpeed',1.75)
end
elseif name == 'Trigger' and v1 == 'colours' then
setProperty('dad.color',getColorFromHex('000000'))
setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('bg8.alpha',1)
for i = 4,7 do
setProperty('bg'..(i-3)..'.alpha',0)
end
elseif name == 'Trigger' and v1 == 'outside' then
setProperty('vig.alpha',1)
setObjectOrder('dadGroup',getObjectOrder('boyfriendGroup')+1)
setProperty('bg8.alpha',0)
doTweenX('bg6die','bg6',2000,15,'linear')
for i = 4,7 do
setProperty('bg'..i..'.alpha',1)
end
if not middlescroll then
alreadySwapped = true
for i = 0, 3 do
j = (i + 4)

iPos = _G['defaultPlayerStrumX'..i];
jPos = _G['defaultOpponentStrumX'..i];
if alreadySwapped then
iPos = _G['defaultOpponentStrumX'..i];
jPos = _G['defaultPlayerStrumX'..i];
end
noteTweenX('note'..i..'TwnX', i, iPos, 1.25, 'cubeInOut');
noteTweenX('note'..j..'TwnX', j, jPos, 1.25, 'cubeInOut');
end
end
end
end

function onTweenCompleted(tag)
if tag == 'bg6die' then
setProperty('bg6.x',-850)
doTweenX('bg6die','bg6',2000,15,'linear')
end
end
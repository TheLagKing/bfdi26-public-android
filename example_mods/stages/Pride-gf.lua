function onSongStart()
setProperty('textacc.x',getProperty('scoreTxt.x')+600)
setProperty('textmiss.x',getProperty('scoreTxt.x')+275)
doTweenColor('healthTween','healthBar.leftBar','FF0000',1.5)

alreadySwapped = true
if not middlescroll then
for i = 0, 3 do
j = (i + 4)

iPos = _G['defaultPlayerStrumX'..i];
jPos = _G['defaultOpponentStrumX'..i];
if alreadySwapped then
iPos = _G['defaultOpponentStrumX'..i]-60;
jPos = _G['defaultPlayerStrumX'..i]-60;
end
noteTweenX('note'..i..'TwnX', i, iPos, 1.25, 'cubeInOut');
noteTweenX('note'..j..'TwnX', j, jPos, 1.25, 'cubeInOut');
end
else
for p= 4,7 do
noteTweenX('movePlayer'..p, p,277.5 + (110 *(p - 4)), 1.25,'quadInOut')
end
for p = 0,1 do
noteTweenX('moveOpponent'..p, p,490 + (115 *(p - 4)), 1.25,'quadInOut')
end
for u = 2,3 do
noteTweenX('moveOpponent'..u, u,960 + (115 *(u - 4)), 1.25,'quadInOut')
end
end
end

function onTweenCompleted(tag)
if tag == 'healthTween' then
doTweenColor('healthTween2','healthBar.leftBar','00FF00',1.5)
elseif tag == 'healthTween2' then
doTweenColor('healthTween3','healthBar.leftBar','0000FF',1.5)
elseif tag == 'healthTween3' then
doTweenColor('healthTween','healthBar.leftBar','FF0000',1.5)
end
end

function onCreate() 
setProperty('camZooming',true)
setProperty('camGame.bgColor', getColorFromHex('0A0912'))
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeAnimatedLuaSprite('speaker','backgrounds/web-crasher/gf/speaker',610,875)
addAnimationByPrefix('speaker','bop','speaker',24,true)
addLuaSprite('speaker',false)

makeLuaSprite('white', '', 0, 0)
setScrollFactor('white', 0, 0)
makeGraphic('white',1280,720,'FFFFFF')
setProperty('white.alpha',0)
scaleObject('white',2,2)
addLuaSprite('white',false)
screenCenter('white', 'xy')

makeAnimatedLuaSprite('star','backgrounds/web-crasher/gf/starGlimmer',410,575)
addAnimationByPrefix('star','bop','starGlimmer',24,true)
setScrollFactor('star',0.9,0.9)
addLuaSprite('star',false)
setProperty('star.alpha',0)

makeLuaSprite('tree','backgrounds/web-crasher/gf/bgsuperplerm',760,670)
setProperty('tree.alpha',0.001)
scaleObject('tree',0.9,0.9)
setProperty('tree.antialiasing',false)
addLuaSprite('tree')

makeLuaSprite('hyper','backgrounds/web-crasher/hypercam',625,0)
setObjectCamera('hyper','other')
scaleObject('hyper',0.25,0.25)
addLuaSprite('hyper',false)
end

function onCreatePost()
setProperty('gf.visible',false)
setProperty('camGame.x',-200)

if (shadersEnabled) then
initLuaShader("compressed");
setSpriteShader('hyper','compressed')
end
end

function onSectionHit()
if not mustHitSection then
triggerEvent('Play Animation','idle-alt','gf')
triggerEvent('Alt Idle Animation','gf','-alt')
elseif mustHitSection then
triggerEvent('Play Animation','idle','gf')
triggerEvent('Alt Idle Animation','gf','')
end
end

function onBeatHit()
if curBeat % 4 == 0 then
makeStar()
end
end

local colorArray = {'02f4f6','f402f6','f3f304','f40204','02f42d','FFFFFF'}
local Color = 1

function makeStar()
Color = getRandomInt(1, #colorArray, Color)
setProperty('star.color',getColorFromHex(colorArray[Color]))
scaleObject('star',1,1)
setProperty('star.alpha',1)
setProperty('star.angle',0)
setProperty('star.x',getRandomInt(200,1100))
setProperty('star.y',getRandomInt(550,300))
doTweenAngle('starspin','star',360,1.75,'circOut')
doTweenX('stargodown','star.scale',1.5,1.5)
doTweenY('stargodown2','star.scale',1.5,1.5)
doTweenAlpha('stargodown3','star',0,1.25)
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'human' then
doTweenZoom('goout','camGame',0.95,1.5,'cubeInOut')
setProperty('defaultCamZoom',0.95)
setProperty('cameraSpeed',1.25)
setProperty('gf.visible',true)
setProperty('isCameraOnForcedPos', false)
setProperty('dadGroup.x',200)
setProperty('boyfriendGroup.x',750)
doTweenAlpha('treeout','tree',0,1.25,'quadOut')
elseif name == 'Trigger' and v1 == 'fade' then
doTweenAlpha('whitecomein','white',1,1.25,'quadOut')
doTweenAlpha('banbye','hyper',0,0.5,'quadOut')
elseif name == 'Trigger' and v1 == 's2' then
setProperty('isCameraOnForcedPos', true)
setProperty('dadGroup.x',getProperty('dadGroup.x')+100)
setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x')-100)
elseif name == 'Trigger' and v1 == 'pixel' then
doTweenZoom('goin','camGame',3.2,0.001,'')
setProperty('defaultCamZoom',3.2)
doTweenAlpha('treein','tree',1,1.25,'quadOut')
setProperty('isCameraOnForcedPos', true)
setProperty('camFollow.y',900)
setProperty('camFollow.x',845)
setProperty('dadGroup.x',getProperty('dadGroup.x')+175)
setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x')-175)
setProperty('gf.visible',false)
elseif name == 'Trigger' and v1 == 'startend' then
doTweenAlpha('whitecomein2','white',0,1.25,'quadOut')
setProperty('gf.visible',false)
removeLuaSprite('speaker')
setProperty('dadGroup.x',getProperty('dadGroup.x')+100)
setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x')-100)
setProperty('isCameraOnForcedPos', true)
setProperty('camFollow.y',750)
setProperty('camFollow.x',745)
end
end
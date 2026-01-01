bopstuff = false
notreact = true

function onCreate()
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)
-- background shit
makeLuaSprite('background', 'backgrounds/evil-song/evilbackground',-600,50)
addLuaSprite('background',false)

if songName == 'evil-song-pico' then
setProperty('defaultCamZoom',0.3)
loadGraphic('background','backgrounds/evil-song/bg hole')
setScrollFactor('background',0.9,0.9)
setProperty('background.y',-100)

makeAnimatedLuaSprite('daddy','backgrounds/evil-song/daddy',2290,275)
addAnimationByPrefix('daddy','bop','daddy long legs instance 1',24,false)
setScrollFactor('daddy',0.9,0.9)
addLuaSprite('daddy',false)

makeAnimatedLuaSprite('spraypaint','backgrounds/evil-song/spraypaint sheet',1000,900)
addAnimationByPrefix('spraypaint','bop','spraypaint idle instance 1',24,false)
addAnimationByPrefix('spraypaint','react','spraypaint react instance 1',24,false)
setScrollFactor('spraypaint',0.9,0.9)
addLuaSprite('spraypaint',false)

makeAnimatedLuaSprite('peanut','backgrounds/evil-song/peanut sheet',1390,840)
addAnimationByPrefix('peanut','bop','peanut bg instance 1',24,false)
addAnimationByPrefix('peanut','react','peanut bg react instance 1',24,false)
setScrollFactor('peanut',0.9,0.9)
addLuaSprite('peanut',false)

makeLuaSprite('dirt','backgrounds/evil-song/dirty wirty',865,1150)
setScrollFactor('dirt',0.9,0.9)
addLuaSprite('dirt',false)
if not hideCards then
makeLuaSprite('l', 'rendersnlogos/limey render',1500,300)
setObjectCamera('l','camHUD')
addLuaSprite('l',true)

makeLuaSprite('s', 'rendersnlogos/sour apple render',-850,275)
setObjectCamera('s','camHUD')
addLuaSprite('s',true)

makeAnimatedLuaSprite('logos', 'rendersnlogos/evil pico titlecard mhm',0,0)
addAnimationByPrefix('logos', 'title', 'EVIL TITLECARD instance 1',24,true)
scaleObject('logos',3,3)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',true)
end


setProperty('defaultCamZoom',0.7)
else
if not hideCards then
makeAnimatedLuaSprite('logos', 'rendersnlogos/evilsongtitle',0,0)
addAnimationByPrefix('logos', 'title', 'Symbol 3 copy 8',12,true)
scaleObject('logos',1.35,1.35)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',true)

makeAnimatedLuaSprite('l', 'rendersnlogos/Limeyea',1000,30)
addAnimationByPrefix('l', 'limey', 'Limey',24,true)
setProperty('l.alpha',0)
setObjectCamera('l','camHUD')
addLuaSprite('l',true)
end
end
end

function onCreatePost()
if downscroll then
setProperty('s.y',-25)
setProperty('l.y',-10)
end

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
if middlescroll == true then
noteTweenX('note'..i..'TwnX',j,iPos, 1.25, 'cubeInOut');
noteTweenX('note'..j..'TwnX',i,jPos, 1.25, 'cubeInOut');
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

function onBeatHit()
if curBeat % 2 == 0 and songName == 'evil-song-pico' and notreact == true then
objectPlayAnimation('peanut','bop')
objectPlayAnimation('daddy','bop')
objectPlayAnimation('spraypaint','bop')
end

if bopstuff == true then
if curBeat % 2 == 0 then
setProperty('camGame.angle',2)
setProperty('camHUD.angle',2)
setProperty('bars.angle',-1)
doTweenAngle('camgamestuff','camGame',0,1,'circOut')
doTweenAngle('camhudstuff','camHUD',0,1,'circOut')
triggerEvent("Add Camera Zoom", 0.015 % 2, 0.075)
elseif curBeat % 2 == 1 then
setProperty('camGame.angle',-2)
setProperty('camHUD.angle',-2)
setProperty('bars.angle',1)
doTweenAngle('camgamestuff','camGame',0,1,'circOut')
doTweenAngle('camhudstuff','camHUD',0,1,'circOut')
triggerEvent("Add Camera Zoom", 0.015 % 2, 0.075)
end
end
end

function onEvent(n,v1)
if n == 'Trigger' and v1 == 'bop' then
bopstuff = true
elseif n == 'Trigger' and v1 == 'nobop' then
bopstuff = false
setProperty('camGame.angle',2)
setProperty('camHUD.angle',2)
setProperty('bars.angle',-1)
doTweenAngle('camgamestuff','camGame',0,1,'circOut')
doTweenAngle('camhudstuff','camHUD',0,1,'circOut')
doTweenAngle('barsstuff','bars',0,1,'circOut')
triggerEvent("Add Camera Zoom", 0.015 % 2, 0.075)
elseif n == 'Trigger' and v1 == 'bopdance' then
cameraSetTarget('dad')
setProperty('defaultCamZoom',1.65)
triggerEvent('Play Animation','dance','dad')
elseif n == 'Trigger' and v1 == 'fade' then
triggerEvent("Add Camera Zoom", 0.015 % 2, 0.075)
doTweenAlpha('camhuddie','camHUD',0,1,'quadOut')

elseif n == 'Trigger' and v1 == 'react' then
notreact = false
objectPlayAnimation('spraypaint','react')
objectPlayAnimation('peanut','react')

elseif n == 'Trigger' and v1 == 'lockinmiddle' then
setProperty('camZooming',false)
setProperty('isCameraOnForcedPos', true)
doTweenX('camX3', 'camFollow',1350,2,'cubeInOut')
doTweenY('camY4', 'camFollow',1200,3.5,'cubeInOut')
doTweenZoom('camGamehihi2','camGame',0.7,4.5,'cubeInOut')

elseif n == 'Trigger' and v1 == 'daddyfocus' then
setProperty('camZooming',false)
setProperty('isCameraOnForcedPos', true)
doTweenX('camX23', 'camFollow',2550,1.5,'cubeInOut')
doTweenY('camY42', 'camFollow',400,3,'cubeInOut')
doTweenZoom('camGamehihi232','camGame',1.5,4,'cubeInOut')

elseif n == 'Trigger' and v1 == 'bopagain' then
objectPlayAnimation('peanut','bop')
objectPlayAnimation('daddy','bop')
objectPlayAnimation('spraypaint','bop')
notreact = true
end
end

function onSongStart()
if songName == 'evil-song-pico' then
objectPlayAnimation('peanut','bop')
objectPlayAnimation('daddy','bop')
objectPlayAnimation('spraypaint','bop')
end
end
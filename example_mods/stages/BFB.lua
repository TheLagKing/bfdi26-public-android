function onCreate()
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)
-- background shit
makeLuaSprite('bg', 'backgrounds/vocalchords/vocalchordsbg',-1000,100)
setProperty('bg.alpha',1)
setScrollFactor('bg',1,1)
addLuaSprite('bg',false)

makeAnimatedLuaSprite('clock','backgrounds/vocalchords/clock',500,1161)
addAnimationByPrefix('clock','idle','clock0',24,false)
addLuaSprite('clock',true)
if not hideCards then
makeLuaSprite('t', 'rendersnlogos/teardrop-portrait',1400,50)
setProperty('t.alpha',0)
scaleObject('t',0.65,0.65)
setObjectCamera('t','camHUD')
addLuaSprite('t',true)

makeLuaSprite('logo', 'rendersnlogos/vocal chords',-750,175)
scaleObject('logo',0.5,0.5)
setProperty('logo.alpha',1)
setObjectCamera('logo','camHUD')
addLuaSprite('logo',true)
end
end

function onBeatHit()
if curBeat % 2 == 0 then
playAnim('clock','idle')
end
end

function onSectionHit()
if mustHitSection then
setProperty('gf.flipX',false)
else
setProperty('gf.flipX',true)
end
end

function onCreatePost()
for i = 0, 3 do
j = (i + 4)

noteTweenAlpha('notelive'..i,i,1,0.01)
noteTweenAlpha('notelive'..j,j,1,0.01)
iPos = _G['defaultPlayerStrumX'..i];
jPos = _G['defaultOpponentStrumX'..i];
if alreadySwapped then
	iPos = _G['defaultOpponentStrumX'..i];
	jPos = _G['defaultPlayerStrumX'..i];
end
noteTweenX('note'..i..'TwnX', i, iPos, 0.001, 'cubeInOut');
noteTweenX('note'..j..'TwnX', j, jPos, 0.001, 'cubeInOut');
if middlescroll == true then
noteTweenX('note'..i..'TwnX',j,iPos, 0.001, 'cubeInOut');
noteTweenX('note'..j..'TwnX',i,jPos, 0.001, 'cubeInOut');
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

function onStepHit()
if curStep == 256 then
setProperty('camZooming',true)
setProperty('defaultCamZoom',0.775)
elseif curStep == 512 then
doTweenAlpha('groundgo','bg',0,27,'quadOut')
elseif curStep == 784 then
cancelTween('groundgo')
doTweenAlpha('groundgo2','bg',1,0.625,'quadOut')
end
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'renderin' then
doTweenX('logoshit5','t',700,1.75,'circOut')
doTweenAlpha('logoshit3','t',1,2,'quadOut')
doTweenX('logos','logo',0,1.25,'circOut')
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenX('logoshit6','t',1400,2,'quadIn')
doTweenAlpha('logoshit4','t',0,2,'quadOut')
doTweenX('logos2','logo',-750,1.25,'circIn')
end
end
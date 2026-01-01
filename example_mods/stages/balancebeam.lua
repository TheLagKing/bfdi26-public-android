nocam = false

function onCreate()
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)
setProperty('camGame.alpha',0)
setProperty('camHUD.alpha',0)
-- background shit
makeLuaSprite('beam', 'backgrounds/wrongfinger/balance',-600,50)
setProperty('beam.alpha',1)
setScrollFactor('beam',1,1)
addLuaSprite('beam',false)

makeAnimatedLuaSprite('l', 'rendersnlogos/leafy render',-1000,-70)
addAnimationByPrefix('l','leafy','Leafy Idle instance',12,true)
setProperty('l.alpha',0)
scaleObject('l',0.85,0.85)
setObjectCamera('l','camHUD')
addLuaSprite('l',false)

makeAnimatedLuaSprite('p', 'rendersnlogos/pin render',2000,-75)
addAnimationByPrefix('p','pin','Pin Idle instance',12,true)
setProperty('p.alpha',0)
scaleObject('p',0.85,0.85)
setObjectCamera('p','camHUD')
addLuaSprite('p',false)

if not hideCards then
makeLuaSprite('logos', 'rendersnlogos/frong winger titlecard',0,275)
scaleObject('logos',0.85,0.85)
screenCenter('logos','x')
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',true)
end
end

function onCreatePost()
setObjectCamera('gf','other')
screenCenter('gf','xy')
setProperty('gf.x',75)
setProperty('gf.y',400)
end

function onUpdatePost(elapsed)
if nocam == true then
setProperty('camZooming',false)
else
setProperty('camZooming',true)
end
end

function onSongStart()
setProperty('isCameraOnForcedPos', true)
doTweenX('camX3', 'camFollow',getProperty('dad.x')+475,6.5,'cubeInOut')
doTweenY('camY4', 'camFollow',getProperty('dad.y')+150,7.5,'cubeInOut')
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'renderin' then
setProperty('camGame.alpha',1)
cameraFlash('camHUD', 'FFFFFF',0.5);
setProperty('defaultCamZoom',1)
setProperty('camZooming',true)
if not hideCards then
doTweenAlpha('logoshit','logos',1,1.5,'quadOut')
doTweenX('logoshit5','l',-100,1.75,'circOut')
doTweenX('logoshit51','p',775,1.75,'circOut')
doTweenAlpha('logoshit13','p',1,2,'quadOut')
doTweenAlpha('logoshit3','l',1,2,'quadOut')
end
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenAlpha('logoshit2','logos',0,2,'quadOut')
doTweenX('logoshit6','l',-1000,2,'quadIn')
doTweenAlpha('logoshit4','l',0,2,'quadOut')
doTweenX('logoshit26','p',2000,2,'quadIn')
doTweenAlpha('logoshit43','p',0,2,'quadOut')
elseif name == 'Trigger' and v1 == 'move' then
setProperty('camZooming',false)
doTweenZoom('cmagame','camGame',5,1.25,'quadIn')
setProperty('defaultCamZoom',5)
nocam = true
elseif name == 'Trigger' and v1 == 'unmove' then
nocam = false
doTweenX('logoshit6','l',-1000,2,'quadIn')
doTweenAlpha('logoshit4','l',0,2,'quadOut')
doTweenX('logoshit26','p',2000,2,'quadIn')
doTweenAlpha('logoshit43','p',0,2,'quadOut')
elseif name == 'Trigger' and v1 == 'lockin' then
doTweenX('logoshit52','l',-100,1.75,'circOut')
doTweenAlpha('logoshit3','l',1,2,'quadOut')
doTweenX('logoshit51','p',775,1.75,'circOut')
doTweenAlpha('logoshit13','p',1,2,'quadOut')
doTweenAlpha('logoshit13','p',1,2,'quadOut')
doTweenAlpha('logoshit3','l',1,2,'quadOut')
elseif name == 'Trigger' and v1 == 'cutscene-end' then
doTweenAlpha('camhudactivate','camHUD',1,1.25,'quadOut')
doTweenY('wrong','gf',getProperty('gf.y')+1125,1,'cubeInOut')
doTweenAngle('wrong2','gf',45,3,'sineOut')
end
end
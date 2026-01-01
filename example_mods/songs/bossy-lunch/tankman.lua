idleplay = false

Notes = {'left','down','up','right'}
Cam = 10

Xsection = false
XhealthColorArray = {125,125,125}

local function rgbToHex(t)
return string.format('%02X%02X%02X', t[1], t[2], t[3])
end

function onCreate()
makeAnimatedLuaSprite('tankman','characters/bossy-lunchbox/tankblud',-590,592.5)
addAnimationByPrefix('tankman','transition','transition0',24,false)
addAnimationByPrefix('tankman','slidein','slideidle0',24,false)
addAnimationByPrefix('tankman','idle','idle0',24,false)
for i = 1,#Notes do
addAnimationByPrefix('tankman',Notes[i],''..Notes[i]..'0',24,false)
end

addLuaSprite('tankman',false)
end

function onBeatHit()
if curBeat % 2 == 0 and idleplay == true then
objectPlayAnimation('tankman','idle')
setProperty('tankman.y',592.5)
end
end

directions = ''

function opponentNoteHit(id, direction, noteType, isSustainNote)
directions = direction
if noteType == 'No Animation' then
playAnim('tankman',Notes[directions+1],true)
runTimer('idlereturn',0.5)
idleplay = false

if not isSustainNote then
if Notes[direction+1] == 'down' then
setProperty('tankman.y',592.5+15.5)
setProperty('camFollow.y',getProperty('camFollow.y')+Cam)
elseif Notes[direction+1] == 'left' then
setProperty('tankman.y',592.5+6.5)
setProperty('camFollow.x',getProperty('camFollow.x')-Cam)
elseif Notes[direction+1] == 'up' then
setProperty('tankman.y',592.5-17)
setProperty('camFollow.y',getProperty('camFollow.y')-Cam)
elseif Notes[direction+1] == 'right' then
setProperty('tankman.y',592.5-1)
setProperty('camFollow.x',getProperty('camFollow.x')+Cam)
end

if isSustainNote then
playAnim('tankman',Notes[directions+1],true)
runTimer('idlereturn',sustainTime+0.5)
idleplay = false
end
end
end
end

function onTimerCompleted(tag)
if tag == 'idlereturn' then
objectPlayAnimation('tankman','idle')
setProperty('tankman.y',592.5)
idleplay = true
end
end

function onEvent(name,v1,v2)
if name == 'Trigger' and v1 == 'tankidle' then
idleplay = true
objectPlayAnimation('tankman','idle')
elseif name == 'Trigger' and v1 == 'disable' then
Cam = 0
elseif name == 'Trigger' and v1 == 'enable' then    
Cam = 10
elseif name == 'Trigger' and v1 == 'iconswapDB' then
callMethod('iconP2.changeIcon', {'icon-army'})
callMethod('iconP1.changeIcon', {getProperty('boyfriend.healthIcon')})
setProperty('health',getProperty('health'))
setHealthBarColors(rgbToHex(XhealthColorArray), rgbToHex(getProperty('boyfriend.healthColorArray')))
setProperty('health',getProperty('health'))
elseif name == 'Trigger' and v1 == 'iconswapDG' then
callMethod('iconP2.changeIcon', {'icon-army'})
callMethod('iconP1.changeIcon', {getProperty('gf.healthIcon')})
setHealthBarColors(rgbToHex(XhealthColorArray), rgbToHex(getProperty('gf.healthColorArray')))
setProperty('health',getProperty('health'))
elseif name == 'Trigger' and v1 == 'iconswapBack' then
callMethod('iconP2.changeIcon', {'icon-golfball'})
callMethod('iconP1.changeIcon', {getProperty('boyfriend.healthIcon')})
setHealthBarColors(rgbToHex(getProperty('dad.healthColorArray')), rgbToHex(getProperty('boyfriend.healthColorArray')))
setProperty('health',getProperty('health'))
elseif name == 'Trigger' and v1 == 'iconswapBackG' then
callMethod('iconP2.changeIcon', {'icon-golfball'})
callMethod('iconP1.changeIcon', {getProperty('gf.healthIcon')})
setHealthBarColors(rgbToHex(getProperty('dad.healthColorArray')), rgbToHex(getProperty('gf.healthColorArray')))
setProperty('health',getProperty('health'))
end
end
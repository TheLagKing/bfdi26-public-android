focus = 0
tbdie = false

function onSongStart()
objectPlayAnimation('tb','oblink')
end

function onCreate() 
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeLuaSprite('back','backgrounds/bossy/lunch/lunchboxmainbg',-75,25)
addLuaSprite('back')

makeAnimatedLuaSprite('tb','characters/bossy-lunchbox/tblunchbox',775,650)
addAnimationByPrefix('tb','opponent','gbpeep instance 1',24,false)
addAnimationByPrefix('tb','oblink','switchgb instance 1',24,false)
addAnimationByPrefix('tb','player','playerpeep instance 1',24,false)
addAnimationByPrefix('tb','pblink','switchlunch instance 1',24,false)
addAnimationByPrefix('tb','ah','ranover instance 1',24,false)
addAnimationByPrefix('tb','roll','roll instance 1',24,false)
addLuaSprite('tb')

makeLuaSprite('tree','backgrounds/bossy/lunch/evil fucking glue tree',0,75)
addLuaSprite('tree',true)
end

function onCreatePost()
setProperty('gf.flipX',false)
setScrollFactor('gfGroup',1,1)
end

function onSectionHit()
if mustHitSection and focus ~= 1 and tbdie == false then
objectPlayAnimation('tb','pblink')
elseif not mustHitSection and focus ~= 2 and tbdie == false then
objectPlayAnimation('tb','oblink')
end

local function rgbToHex(t)
return string.format('%02X%02X%02X', t[1], t[2], t[3])
end

if gfSection and tbdie == false then
callMethod('iconP1.changeIcon', {getProperty('gf.healthIcon')})
setHealthBarColors(rgbToHex(getProperty('dad.healthColorArray')), rgbToHex(getProperty('gf.healthColorArray')))
setProperty('health',getProperty('health'))
elseif not gfSection and tbdie == false then
callMethod('iconP1.changeIcon', {getProperty('boyfriend.healthIcon')})
setHealthBarColors(rgbToHex(getProperty('dad.healthColorArray')), rgbToHex(getProperty('boyfriend.healthColorArray')))
setProperty('health',getProperty('health'))
end
end



function onUpdatePost()
if getProperty('tb.animation.curAnim.finished') and getProperty("tb.animation.curAnim.name") == 'pblink' and tbdie == false then
focus = 1
elseif getProperty('tb.animation.curAnim.finished') and getProperty("tb.animation.curAnim.name") == 'oblink' and tbdie == false then
focus = 2
end
end

function onBeatHit()
if curBeat % 2 == 0 and focus == 2 and tbdie == false then
objectPlayAnimation('tb','player')
elseif curBeat % 2 == 0 and focus == 1 and tbdie == false then
objectPlayAnimation('tb','opponent')
end
end

function onEvent(name,v1,v2)
if name == 'Trigger' and v1 == 'comein' then
setProperty('isCameraOnForcedPos', true)
setProperty('camZooming',false)
doTweenX('tankmanarrives','tankman',290,2.2,'circIn')

doTweenZoom('focustankzoom','camGame',1.1,3,'cubeInOut')
setProperty('defaultCamZoom',1.1)
doTweenX('focustankx','camFollow',950,2.75,'cubeInOut')
doTweenY('focustanky','camFollow',750,2.25,'cubeInOut')
doTweenAlpha('gbalpha','dadGroup',0.5,1.25,'quadOut')
doTweenAlpha('gbalpha2','tree',0.5,1.25,'quadOut')
elseif name == 'Trigger' and v1 == 'react' then
tbdie = true
objectPlayAnimation('tankman','slidein')
objectPlayAnimation('tb','ah')
elseif name == 'Trigger' and v1 == 'tbrip' then
cancelTween('tankmanarrives')
objectPlayAnimation('tankman','transition')
objectPlayAnimation('tb','roll')
doTweenX('tankmanarrives2','tankman',600,1.25,'circOut')
doTweenX('byetb','tb',2300,2,'elasticOut')
elseif name == 'Trigger' and v1 == 'focustank' then
setProperty('isCameraOnForcedPos', true)
setProperty('defaultCamZoom',1.1)
setProperty('camFollow.x',950)
setProperty('camFollow.y',750)

cancelTween('gbalpha3')
cancelTween('gbalpha4')
doTweenAlpha('gbalpha','dadGroup',0.5,1.25,'quadOut')
doTweenAlpha('gbalpha2','tree',0.5,1.25,'quadOut')
elseif name == 'Trigger' and v1 == 'unfocustank' then
setProperty('isCameraOnForcedPos', false)
cancelTween('gbalpha')
cancelTween('gbalpha2')
doTweenAlpha('gbalpha3','dadGroup',1,1.25,'quadOut')
doTweenAlpha('gbalpha4','tree',1,1.25,'quadOut')
setProperty('defaultCamZoom',0.7)
elseif name == 'Trigger' and v1 == 'focuschange' then
cameraSetTarget(v2)
elseif name == 'Trigger' and v1 == 'instantzoom' then
doTweenZoom('instantwhatever','camGame',v2,0.001)
setProperty('defaultCamZoom',v2)
end
end
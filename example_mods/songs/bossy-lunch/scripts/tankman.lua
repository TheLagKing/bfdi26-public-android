Xsection = false
XhealthColorArray = {125,125,125}

local function rgbToHex(t)
return string.format('%02X%02X%02X', t[1], t[2], t[3])
end

function onCreate()
createInstance('tankman', 'funkin.objects.Character', {-575, 585, 'tanklunch', false})
addInstance('tankman')
end

function onCountdownTick(counter)
    if getProperty('tankman.danceIdle') or counter % getProperty('tankman.danceEveryNumBeats') == 0 then
        playAnim('tankman','idle')
    end
end

function onBeatHit()
    if Xsection == true then
        if curBeat % getProperty('tankman.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty('tankman.animation.name'), 'sing') and not getProperty('tankman.stunned') then
            playAnim('tankman','idle')
        end
    end
end

function opponentNoteHit(_, d, t,isSustainNote)
    if t == 'No Animation' then
    playAnim('tankman', getProperty('singAnimations')[d+1], true)
    setProperty('tankman.holdTimer', 0)
    triggerEvent('','focus','tankman')
    end
end

function onEvent(name,v1,v2)
if name == 'Trigger' and v1 == 'iconswapDB' then
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
elseif name == 'Trigger' and v1 == 'tankidle' then
Xsection = true
end
end
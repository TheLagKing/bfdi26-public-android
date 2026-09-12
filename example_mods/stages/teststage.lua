function onSongStart()
startTween('cool', 'logos.scale', {x = 0.75, y = 0.75}, 1.75,{startDelay = 0.25, ease = 'quartOut'})
runTimer('end',2.5)
end

function onTimerCompleted(tag)
if tag == 'end' then
startTween('cool2', 'logos.scale', {x = 0, y = 0}, 1.25,{startDelay = 1, ease = 'quintIn'})
runTimer('end2',2.5)
elseif tag == 'end2' then
removeLuaSprite('logos')
end
end

function onCreate() 
setProperty('camGame.bgColor', getColorFromHex('0000FF'))
setProperty('textmiss.alpha',1)

makeLuaSprite('rsky','backgrounds/bfdimemes/sky shit',-900,-775)
setScrollFactor('rsky',0,0)
addLuaSprite('rsky')

makeLuaSprite('rsun','backgrounds/bfdimemes/reddisun',-535,-860)
setScrollFactor('rsun',0.025,0.025)
addLuaSprite('rsun')

makeLuaSprite('bgblue','backgrounds/bfdimemes/the blue shit',-925,-450)
setScrollFactor('bgblue',0.15,0.15)
addLuaSprite('bgblue')

makeLuaSprite('bg1','backgrounds/bfdimemes/big red shit',-775,-435)
setScrollFactor('bg1',0.25,0.25)
addLuaSprite('bg1')

makeLuaSprite('fgbg','backgrounds/bfdimemes/smaller red shit',-755,100)
setScrollFactor('fgbg',0.4,0.4)
addLuaSprite('fgbg')

makeLuaSprite('floor','backgrounds/bfdimemes/floor shit',0,0)
addLuaSprite('floor')

createInstance('momo', 'funkin.objects.Character', {765, 297.5, 'Onemomo', false})
addInstance('momo')
scaleObject('momo',1.5,1.5)
playAnim('momo','stage1')

if not hideCards then
makeLuaSprite('logos', 'rendersnlogos/MEMES CARD',0,0)
setProperty('logos.alpha',1)
scaleObject('logos',0,0)
setObjectCamera('logos','camHUD')
screenCenter('logos','xy')
addLuaSprite('logos',true)
end

makeLuaSprite('blacks', '', 0, 0)
setScrollFactor('blacks', 0, 0)
makeGraphic('blacks',1,1,'000000')
setProperty('blacks.alpha',0)
scaleObject('blacks',1280*2,720*2)
addLuaSprite('blacks',false)
screenCenter('blacks', 'xy')
setObjectOrder('blacks',getObjectOrder('momo'))
end

function onCreatePost()
makeLuaSprite('foid','backgrounds/bfdimemes/madewithmemes',975,665)
setObjectCamera('foid','camOTHER')
addLuaSprite('foid',true)
end

local lastFocus = ''
active = false
function onMoveCamera(focus)
    if lastFocus == focus then return end
if active == true then    
triggerEvent('Play Animation','idle-m','gf') 
    if focus == 'boyfriend' then
triggerEvent('Alt Idle Animation','gf','-r') 
    elseif focus == 'dad' then
triggerEvent('Alt Idle Animation','gf','') 
    end
    lastFocus = focus
end
end

function onEvent(n,v1,v2)
if n == 'Trigger' then
if v1 == 'startlooking' then
active = true
elseif v1 == 'stoplooking' then
active = false
elseif v1 == 'zoom' then
setProperty('isCameraOnForcedPos', true)
startTween('bfmove','camFollow',{x = getMidpointX("boyfriend") - 100 - getProperty("boyfriend.cameraPosition[0]") + getProperty("boyfriendCameraOffset[0]"), y = getMidpointY("boyfriend") - 100 + getProperty("boyfriend.cameraPosition[1]") + getProperty("boyfriendCameraOffset[1]")},2.5,{ease = 'quartInOut'})
elseif v1 == 'center' then
startTween('centermove','camFollow',{x = 1825, y = 450},1.5,{ease = 'quartInOut'})
elseif v1 == 'center2' then
setProperty('isCameraOnForcedPos', true)
setProperty('defaultCamZoom',getProperty('defaultCamZoom')-0.1)
startTween('centermove4','camFollow',{x = 1825, y = 450},1.25/2,{ease = 'circOut'})
doTweenAlpha('blackcomeOUT','blacks',0,1.25/2,'quadOut')
elseif v1 == 'twopan' then
setProperty('defaultCamZoom',getProperty('defaultCamZoom')+0.1)
doTweenAlpha('blackcomein','blacks',0.5,1.25/2,'quadOut')
cameraSetTarget('dad')
elseif v1 == 'panend' then
setProperty('isCameraOnForcedPos', false)
setProperty('defaultCamZoom',getProperty('defaultCamZoom')+0.1)
doTweenAlpha('blackcomeOUT','blacks',0,1.25/2,'quadOut')
elseif v1 == 'stopfight' then
setProperty('isCameraOnForcedPos', true)
startTween('centermove2','camFollow',{x = 1825, y = 450},1.25/2,{ease = 'circOut'})
doTweenAlpha('blackcomein','blacks',0.5,1.25/2,'quadOut')
elseif v1 == 'pinpoint' then
startTween('bfmove','camFollow',{x = 2450, y = 580},1.25/2,{ease = 'circOut'})
elseif v1 == 'ending' then
doTweenAlpha('blackcomeOUT','blacks',0,1.25/2,'quadOut')
startTween('centermove3','camFollow',{x = 1825, y = 450},1.25/2,{ease = 'circOut'})
setProperty('defaultCamZoom',getProperty('defaultCamZoom')-1)
elseif v1 == 'dis' then
setProperty('isCameraOnForcedPos', false)
setProperty('defaultCamZoom',getProperty('defaultCamZoom')+0.1)
elseif v1 == 'huddie' then
doTweenAlpha('camHUDDIE','camHUD',0,1.25/2,'circOut')
setProperty('defaultCamZoom',getProperty('defaultCamZoom')-0.1)
end

if v1 == 'momostage' then
Momo(v2)
end

end
end

function Momo(stage)
playAnim('momo','stage'..stage..'')
end

function onGameOver()
runHaxeCode([[FlxG.openURL('https://www.reddit.com/r/BFDImemes');]])
end
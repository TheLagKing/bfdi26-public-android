function onSongStart()
startTween('blackout2','black',{alpha = 0}, 10,{startDelay = 2.5,ease = 'cubeInOut'})
end

function onCreate()
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)
setProperty('camGame.bgColor', getColorFromHex('191C32'))
precacheImage('backgrounds/bozobrain/cool bg')

makeLuaSprite('bozobg','backgrounds/bozobrain/cool bg unmarred',-1000,0)
addLuaSprite('bozobg')

makeLuaSprite('v', 'backgrounds/oneshot/vignette',0,0)
setProperty('v.alpha',1)
setObjectCamera('v','camHUD')
addLuaSprite('v',true)

makeLuaSprite('black', '', 0, 0)
setScrollFactor('black', 0, 0)
makeGraphic('black',1,1,'000000')
setProperty('black.alpha',1)
setObjectCamera('black','other')
scaleObject('black',1280,720)
addLuaSprite('black',false)
screenCenter('black', 'xy')
end

function onEvent(n,v1)
if n == 'Trigger' then
if v1 == 'bgswitch' then
loadGraphic('bozobg','backgrounds/bozobrain/cool bg')
startTween('blackout3','black',{alpha = 0}, 1.25/2,{startDelay = 0,ease = 'circOut'})
elseif v1 == 'black' then
startTween('blackout','black',{alpha = 1}, 1.25/2,{startDelay = 0,ease = 'circOut'})
end
end
end
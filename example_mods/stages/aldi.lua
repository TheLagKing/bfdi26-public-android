local shopper = {'cobsandphone','walletcrashout','micandtaco','caryhuang'}
local shopperv = 1


function onCreate() 
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeLuaSprite('aldi','backgrounds/aldi/aldi',-400,150)
scaleObject('aldi',1.5,1.5)
addLuaSprite('aldi',false)

makeAnimatedLuaSprite('babes','characters/aldi/babe voiceline',45,865)
addAnimationByPrefix('babes','deserve','suitcase voiceline instance 1',24,false)
addLuaSprite('babes',true)
setProperty('babes.alpha',0.001)

makeLuaSprite('shopper','backgrounds/aldi/cobsandphone',-700,750)
addLuaSprite('shopper',true)
setScrollFactor('shopper',1.05,1.05)

makeLuaSprite('border','',-62.5,0)
makeGraphic('border',415,1080,'000000')
addLuaSprite('border',false)
setObjectCamera('border','other')

makeLuaSprite('border2','',927.5,0)
makeGraphic('border2',470,1080,'000000')
addLuaSprite('border2',false)
setObjectCamera('border2','other')

makeAnimatedLuaSprite('adamdies','backgrounds/aldi/AdamFuckingGetsRunOver',-350,200)
addAnimationByPrefix('adamdies','death','AdamFuckingGetsRunOver CarHit0',24,false)
setProperty('adamdies.alpha',0.001)
scaleObject('adamdies',1.49,1.49)
addLuaSprite('adamdies',false)
end

function onCreatePost()
setProperty('gfGroup.y',-1000)
setScrollFactor('gfGroup',0.99,0.99)
runTimer('shoppercome',getRandomInt(25,45))
end

function onUpdatePost()
if (shadersEnabled) then
setShaderFloat('aldi','iTime',os.clock()*2)
end
end

function onTimerCompleted(tag)
if tag == 'shoppercome' then
shopperv = getRandomInt(1,4,shopperv)
loadGraphic('shopper','backgrounds/aldi/'..shopper[shopperv]..'')

if shopperv >2 then
setProperty('shopper.x',2000)
doTweenX('shopperx1','shopper',-1000,getRandomInt(10,20))
else
setProperty('shopper.x',-700)
doTweenX('shopperx2','shopper',1500,getRandomInt(10,20))
end

runTimer('shoppercome',getRandomInt(25,45))
end
end

function onBeatHit()
if curBeat % 2 == 0 then
setProperty('shopper.y',775)
doTweenY('shopperystuff','shopper',750,1,'circOut')
end
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'wannaknow' then
setProperty('camHUD.alpha',0)
setObjectCamera('bars','other')
startTween('border1','border',{x = -465}, 2,{startDelay = 3.35, ease = 'cubeIn'})
startTween('border2','border2',{x = 1325}, 2,{startDelay = 3.35, ease = 'cubeIn'})
doTweenZoom('camGamewhatever','camGame',3.5,5,'cubeInOut')
elseif name == 'Trigger' and v1 == 'bgstuff' then
doTweenAlpha('aldidie','aldi',0.5,1.25,'quadOut')
elseif name == 'Trigger' and v1 == 'bgstuff2' then
cancelTween('aldidie')
doTweenAlpha('aldidie2','aldi',1,1.25,'circOut')
elseif name == 'Trigger' and v1 == 'move1' then
setProperty('isCameraOnForcedPos',true)
doTweenX('camfollow1','camFollow',650,1.75,'expoIn')
doTweenY('camfollow2','camFollow',740,1.75,'expoIn')
doTweenZoom('camfollow3','camGame',2,2,'expoIn')
setProperty('defaultCamZoom',1.2)
elseif name == 'Trigger' and v1 == 'endstuff' then
setObjectCamera('bars','camHUD')
setProperty('camHUD.alpha',1)
elseif name == 'Trigger' and v1 == 'death' then
objectPlayAnimation('babes','deserve')
setProperty('babes.alpha',1)
setProperty('boyfriend.alpha',0.001)
elseif name == 'Trigger' and v1 == 'deathend' then
setProperty('cameraSpeed',100)
setProperty('camZooming',false)
setProperty('isCameraOnForcedPos',false)
cameraSetTarget('dad')
doTweenZoom('camGamewhatever','camGame',1.15,0.1,'cubeInOut')
setProperty('babes.alpha',0)
setProperty('boyfriend.alpha',1)
setProperty('adamdies.alpha',1)
objectPlayAnimation('adamdies','death')
setProperty('camHUD.alpha',0)
elseif name == 'Trigger' and v1 == 'onein' then
doTweenY('comein','gfGroup',240,1.8,'quadOut')
elseif name == 'Trigger' and v1 == 'oneout' then
doTweenY('comein2','gfGroup',-1000,2,'quadIn')
setProperty('isCameraOnForcedPos',false)
cameraSetTarget('boyfriend')
cancelTween('camfollow3')
setProperty('defaultCamZoom',0.975)
elseif name == 'Trigger' and v1 == 'zoomfinish' then
setProperty('camZooming',false)
setProperty('isCameraOnForcedPos',true)
doTweenX('camfollow1','camFollow',900,2.75,'expoInOut')
doTweenY('camfollow2','camFollow',950,2.75,'expoInOut')
doTweenZoom('camfollow3','camGame',1.5,2.75,'expoInOut')
setProperty('defaultCamZoom',1.5)
elseif name == 'Trigger' and v1 == 'fdudes' then
setProperty('camZooming',false)
elseif name == 'Trigger' and v1 == 'chaos' then
setProperty('camZooming',true)
if (shadersEnabled) then
initLuaShader('twist')
setSpriteShader('aldi','twist')
end
elseif name == 'Trigger' and v1 == 'unchaos' then
if (shadersEnabled) then
removeSpriteShader('aldi')
end
end
end
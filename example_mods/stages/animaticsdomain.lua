function onCreate()
doTweenZoom('camGamehihi','camGame',1,0.001)
setProperty('camHUD.alpha',0)
-- background shit
makeLuaSprite('bg', 'backgrounds/funnyfellow/funnyfellowbgbetter',-100,290)
setProperty('bg.alpha',1)
addLuaSprite('bg',false)

makeAnimatedLuaSprite('demoncore', 'backgrounds/funnyfellow/demon core swing bop',1200,325)
addAnimationByPrefix('demoncore', 'bop', 'demon core swingy instance 1',24,true)
scaleObject('demoncore',1.5,1.5)
setScrollFactor('demoncore',0.95,0.95)
addLuaSprite('demoncore',false)

makeAnimatedLuaSprite('hive', 'backgrounds/funnyfellow/hives golden freddy',1400,225)
addAnimationByPrefix('hive', 'freddy', 'hives instance 1',24,true)
scaleObject('hive',1.5,1.5)
setScrollFactor('hive',0.95,0.95)
addLuaSprite('hive',false)

makeAnimatedLuaSprite('shift', 'backgrounds/funnyfellow/shifty oh hell nah',650,750)
scaleObject('shift',1.5,1.5)
setScrollFactor('shift',0.95,0.95)
addLuaSprite('shift',false)
if not hideCards then
makeLuaSprite('f', 'rendersnlogos/animaticrender',1585,-100)
setProperty('f.alpha',1)
scaleObject('f',0.65,0.65)
setObjectCamera('f','camHUD')
addLuaSprite('f',true)

makeAnimatedLuaSprite('logos', 'rendersnlogos/funnyfellow',0,0)
addAnimationByPrefix('logos', 'title', 'Symbol 3',16,true)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',true)
end
end

function onCreatePost()
setProperty('iconP2.visible',false)
setProperty('dad.visible',false)
end
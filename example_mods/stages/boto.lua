function onCreate() 
setProperty('camZooming',true)
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeLuaSprite('boto','backgrounds/new-friendly/botobackground',-150,100)
addLuaSprite('boto')
if not hideCards then
makeLuaSprite('bt', 'rendersnlogos/botorender',1350,100)
setProperty('bt.alpha',1)
setObjectCamera('bt','camHUD')
scaleObject('bt',0.65,0.65)
addLuaSprite('bt',false)

makeAnimatedLuaSprite('logos', 'rendersnlogos/newfriendlytext',0,0)
addAnimationByPrefix('logos', 'title', 'Symbol 3 copy 1',24,true)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',true)
end
end

function onCreatePost()
for i = 0,3 do
setPropertyFromGroup('strumLineNotes',i,'alpha',0)
end
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'renderin' then
doTweenAlpha('logoshit3','bt',1,2,'quadOut')
doTweenX('logoshit5','bt',500,1.75,'circOut')
doTweenAlpha('logoshit','logos',1,2,'quadOut')
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenX('logoshit6','bt',1350,2,'quadIn')
doTweenAlpha('logoshit4','bt',0,2,'quadOut')
doTweenAlpha('logoshit2','logos',0,2,'quadOut')
end
end
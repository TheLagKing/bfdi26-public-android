function onSongStart()
setProperty('isCameraOnForcedPos', true)
setProperty('camFollow.y',400)
setProperty('camFollow.x',650)

startTween('grass', 'grass.colorTransform', {redOffset = 0, greenOffset = 0, blueOffset = 0}, 0.25,{startDelay = 5.2,ease = 'circOut'})
startTween('building', 'building.colorTransform', {redOffset = 0, greenOffset = 0, blueOffset = 0}, 0.25,{startDelay = 5.3,ease = 'circOut'})
startTween('camhud','camHUD',{alpha = 1}, 1.25,{startDelay = 5.5,ease = 'cubeInOut'})

startTween('dadapa','dad',{alpha = 1}, 6,{startDelay = 0.5,ease = 'cubeInOut'})
startTween('bfapa','boyfriend',{alpha = 1}, 5.75,{startDelay = 0.75,ease = 'cubeInOut'})
end

function onCreate() 
makeLuaSprite('white', '', 0, 0)
setScrollFactor('white', 0, 0)
makeGraphic('white',1,1,'FFFFFF')
scaleObject('white',1280*1.925,1375)
addLuaSprite('white',false)
screenCenter('white', 'xy')

makeLuaSprite('building','backgrounds/yoylecone/FUCKING building',-250,-225)
setScrollFactor('building',0.5,0.5)
addLuaSprite('building')

makeLuaSprite('grass','backgrounds/yoylecone/FUCKING grass',-210,500)
addLuaSprite('grass')

if not hideCards then
makeLuaSprite('brender','rendersnlogos/bobble render',-550,250) -- -50
setObjectCamera('brender','camHUD')
scaleObject('brender',0.5,0.5)
setProperty('brender.alpha',0.01)
addLuaSprite('brender')

makeLuaSprite('borender','rendersnlogos/bocky render',1500,350) -- 1000
setObjectCamera('borender','camHUD')
scaleObject('borender',0.5,0.5)
setProperty('borender.alpha',0.01)
addLuaSprite('borender')

makeLuaSprite('title','rendersnlogos/yoylecone titlecard',0,50)
setObjectCamera('title','camHUD')
scaleObject('title',0.5,0.5)
setProperty('title.alpha',0.01)
screenCenter('title','x')
addLuaSprite('title')

makeLuaSprite('blackk', '', 0, 0)
setScrollFactor('blackk', 0, 0)
makeGraphic('blackk',1,1,'FF0000')
setBlendMode('blackk','multiply')
setProperty('blackk.alpha',0)
setObjectCamera('blackk','other')
scaleObject('blackk',1280,720)
addLuaSprite('blackk',true)
screenCenter('blackk', 'xy')
end

for _, stuff in ipairs({'building','grass'}) do startTween('stuff'..stuff,stuff..'.colorTransform', {redOffset = 255, greenOffset = 255, blueOffset = 255},1,{ease = 'quadOut'}) end
end

function onCreatePost()
setProperty('textmiss.alpha',1)
setProperty('camHUD.alpha',0)
setProperty('dad.alpha',0)
setProperty('boyfriend.alpha',0)
setProperty('textacc.alpha',1)
end

function onEvent(name,v1,v2)
if name == 'Trigger' then
if v1 == 'end' then
cameraFlash('camGame','ffffff',12.5)
setProperty('camHUD.visible',false)
setProperty('camZooming',false)

setProperty('isCameraOnForcedPos', true)
setProperty('camFollow.x',650)
setProperty('camFollow.y',525)

for _, stuff2 in ipairs({'building','grass','title','brender','borender'}) do removeLuaSprite(stuff2) end
end

if v1 == 'red' then
doTweenAlpha('redide','blackk',1,2,'cubeInOut')
doTweenZoom('camGamezoom','camGame',4,2.5,'cubeInOut')
end
end

if not hideCards then
if v1 == 'renderin' then
doTweenAlpha('titlein','title',1,2.5,'quadOut')
doTweenX('titlescare','title.scale',1,22.5)
doTweenY('titlescare2','title.scale',1,22.5)
doTweenY('titlescare3','title',200,15.5,'cubeOut')

doTweenX('comeinb','brender',-50,2.5,'circOut')
doTweenX('comeinb2','borender',900,2.5,'circOut')
doTweenAlpha('comeinb7','brender',1,2.5,'quadOut')
doTweenAlpha('comeinb8','borender',1,2.5,'quadOut')
elseif v1 == 'renderout' then
doTweenAlpha('titleout','title',0,1.25,'quadOut')

doTweenX('comeinb3','brender',-550,1.5,'circIn')
doTweenX('comeinb4','borender',1500,1.5,'circIn')
doTweenAlpha('comeinb5','brender',0,1.5,'quadIn')
doTweenAlpha('comeinb6','borender',0,1.5,'quadIn')
end
end
end
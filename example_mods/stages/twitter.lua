numberof = 1
dadx, dady = getProperty('dadGroup.x'),getProperty('dadGroup.y')
bfx, bfy = getProperty('boyfriendGroup.x'),getProperty('boyfriendGroup.y')

function onCreate() 
setBlendMode('strumbg','')
makeLuaSprite('white', 'backgrounds/track26/a boring gray sky', 0, 0)
setScrollFactor('white',0,0)
addLuaSprite('white',false)
screenCenter('white', 'xy')

makeLuaSprite('bgclouds','backgrounds/track26/cloudy',-2150,-1200)
setScrollFactor('bgclouds',0.1,0.1)
addLuaSprite('bgclouds',false)

makeLuaSprite('ctweet2','backgrounds/track26/QUOTES/TWEET COLUMNS/C'..getRandomInt(1,6)..'',0,0)
setScrollFactor('ctweet2',0.15,0.15)
setProperty('ctweet2.angle',55)
addLuaSprite('ctweet2',false)

makeLuaSprite('bgm','backgrounds/track26/mountainy',-1400,-850)
setScrollFactor('bgm',0.35,0.35)
addLuaSprite('bgm',false)

makeLuaSprite('jnjtweet1','backgrounds/track26/QUOTES/0',1250,-300)
setScrollFactor('jnjtweet1',0.4,0.4)
addLuaSprite('jnjtweet1',false)

makeLuaSprite('ctweet1','backgrounds/track26/QUOTES/TWEET COLUMNS/C'..getRandomInt(1,6)..'',-2050,-300)
setScrollFactor('ctweet1',0.65,0.65)
setProperty('ctweet1.angle',-45)
addLuaSprite('ctweet1',false)

makeAnimatedLuaSprite('bgfour','backgrounds/track26/foury',750,-775)
addAnimationByPrefix('bgfour','foury','four bouncea instance 1',24,true)
setScrollFactor('bgfour',0.35,0.35)
addLuaSprite('bgfour',false)

makeLuaSprite('ctweet3','backgrounds/track26/QUOTES/TWEET COLUMNS/C'..getRandomInt(1,6)..'',0,0)
setScrollFactor('ctweet3',0.75,0.75)
setProperty('ctweet3.angle',95)
addLuaSprite('ctweet3',false)

makeLuaSprite('ctweet4','backgrounds/track26/QUOTES/TWEET COLUMNS/C'..getRandomInt(1,6)..'',2250,1250) 
setScrollFactor('ctweet4',0.65,0.65)
setProperty('ctweet4.angle',-95)
addLuaSprite('ctweet4',false)

makeLuaSprite('bgground','backgrounds/track26/groundery',-1675,-400)
addLuaSprite('bgground',false)

createInstance('hell', 'funkin.objects.Character', {290, -460, 'lichen', false})
addInstance('hell')
setScrollFactor('hell',0.85,0.85)
playAnim('hell','idle')

makeLuaSprite('bghill','backgrounds/track26/hilly',-5000,-5500)
addLuaSprite('bghill',false)

makeLuaSprite('eggy','backgrounds/track26/HATERS/thediamondeggy',-3250,-3550)
addLuaSprite('eggy',true)

makeAnimatedLuaSprite('eggyfire','backgrounds/track26/HATERS/camp fire',-3035,-3310)
addAnimationByPrefix('eggyfire','burn','Symbol 18 instance 1',24,true)
addLuaSprite('eggyfire',true)

makeLuaSprite('blacks', '', 0, 0)
setScrollFactor('blacks', 0, 0)
makeGraphic('blacks',1,1,'000000')
setProperty('blacks.alpha',0)
setScrollFactor('blacks',0,0)
scaleObject('blacks',1280*4.25,720*4.25)
addLuaSprite('blacks',false)
screenCenter('blacks', 'xy')
setObjectOrder('blacks',getObjectOrder('dadGroup')-2)

makeLuaSprite('bgfore','backgrounds/track26/foregroundery',-3250,-850)
setScrollFactor('bgfore',2,2)
addLuaSprite('bgfore',true)
if not hideCards then
makeLuaSprite('logos','rendersnlogos/track26 titlecard',0,0)
setObjectCamera('logos','camOther')
scaleObject('logos',0.2,0.2)
setProperty('logos.alpha',0)
screenCenter('logos','xy')
addLuaSprite('logos',true)
end
--
makeLuaSprite('black', '', 0, 0)
setScrollFactor('black', 0, 0)
makeGraphic('black',1,1,'00FF00')
setBlendMode('black','multiply')
setProperty('black.alpha',0)
setObjectCamera('black','other')
scaleObject('black',1280*1.5,720*1.5)
addLuaSprite('black',true)
screenCenter('black', 'xy')

makeLuaSprite('blackk', '', 0, 0)
setScrollFactor('blackk', 0, 0)
makeGraphic('blackk',1,1,'FF0000')
setBlendMode('blackk','multiply')
setProperty('blackk.alpha',0)
setObjectCamera('blackk','camOther')
scaleObject('blackk',1280,720)
addLuaSprite('blackk',false)
screenCenter('blackk', 'xy')
end

function onSongStart()
doTweenAlpha('logosalpha','logos',1,2.5,'quadOut')
startTween('logoso','logos.scale',{x = 0.5, y = 0.5},2,{ease = 'quartIn'})
end

function onCreatePost()
setProperty('textmiss.alpha',1)
setProperty('textacc.alpha',1)
for _, hudout in ipairs({'gf','boyfriend','dad','hell','camHUD'}) do setProperty(hudout..'.alpha',0) end
end


function onEvent(n,v1,v2)
if n == 'Trigger' then
if v1 =='renderin' then
for _, hudout in ipairs({'gf','boyfriend','dad','hell'}) do startTween(hudout,hudout,{alpha = 1}, 1.25,{ease = 'cubeOut'}) end
startTween('zoom','this',{defaultCamZoom = 0.75},0.25,{ease = 'quartOut'})
startTween('camhud','camHUD',{alpha = 1},0.5,{ease = 'quartOut'})
startTween('logos','logos',{x = 130, y = 60},1.25,{ease = 'cubeInOut'})

elseif v1 == 'renderout' then
doTweenX('logoout','logos',-750,2.5,'circInOut')
elseif v1 == 'out' then
setProperty('isCameraOnForcedPos', true)
startTween('zoom','this',{defaultCamZoom = 0.35},2.5,{ease = 'quartInOut'})
startTween('logos','camFollow',{x = 1075, y = -350},2.5,{ease = 'quintInOut'})
setProperty('blacks.alpha',0.25)
doTweenAlpha('blacksback','blacks',0,2.5,'circOut')
elseif v1 == 'ilike' then
startTween('zoom','this',{defaultCamZoom = 1.35},1.25,{ease = 'quartOut'})
startTween('camfollow2','camFollow',{x = 1475, y = 0},0.25,{ease = 'quintOut'})
doTweenAlpha('blacksin','blacks',0.75,1.25,'circOut')
startTween('camhud2','camHUD',{alpha = 0},0.5,{ease = 'quartOut'})
elseif v1 == 'movewow' then
startTween('camfollow2','camFollow',{x = 400, y = -20},0.4,{ease = 'quartIn'})
elseif v1 == 'stuff' then
setProperty('isCameraOnForcedPos', false)
startTween('zoom2','this',{defaultCamZoom = 0.35},1.25,{ease = 'quartInOut'})
startTween('lnew','camFollow',{x = 745, y = 0},1.05,{ease = 'quintInOut'})
doTweenAlpha('blacksout3','blacks',0,1.25,'quadOut')
startTween('camhud3','camHUD',{alpha = 1},0.5,{ease = 'quartOut'})
angry = true
elseif v1 == 'movething' then
angry = false
setProperty('isCameraOnForcedPos', true)
startTween('zoom','this',{defaultCamZoom = 3},3.5/2,{ease = 'quartInOut'})
startTween('logosn32','camFollow',{x = -3500, y = 0},3/2,{ease = 'quintInOut'})
for _, dont in ipairs({'bgfour','bgclouds','bgm','jnjtweet1'}) do startTween(dont,dont,{angle = 90, x = getProperty(dont..'.x')-1000,y = getProperty(dont..'.y')-775},3.5/2,{ease = 'quintInOut'}) end
startTween('thing','camGame',{angle = -90},3.5/2,{ease = 'quintInOut'})
runTimer('thing',3.6/2)
elseif v1 == 'movething2' then
angry = false
setProperty('isCameraOnForcedPos', true)
startTween('zoom','this',{defaultCamZoom = 2.3},3.5/2,{ease = 'quartInOut'})
startTween('logosn32','camFollow',{x = -1500, y = -2000},3/2,{ease = 'quintInOut'})
for _, dont in ipairs({'bgfour','bgclouds','bgm','jnjtweet1'}) do startTween(dont,dont,{angle = 90, x = getProperty(dont..'.x')-1000,y = getProperty(dont..'.y')-775},3.5/2,{ease = 'quintInOut'}) end
startTween('thing','camGame',{angle = -90},3.5/2,{ease = 'quintInOut'})
runTimer('thing2',3.6/2)
elseif v1 == 'ctweet2' then
startTween('ctweet2','ctweet2',{angle = -15, y = -1500, x = -500},5.25,{startDelay = 2, ease = 'quintInOut'})
elseif v1 == 'ctweet3' then
startTween('ctweet3','ctweet3',{angle = -15, y = -1275},5.25,{startDelay = 2, ease = 'quintInOut'})
elseif v1 == 'ctweet4' then
startTween('ctweet4','ctweet4',{angle = -15, y = -1250},5.25,{startDelay = 2, ease = 'quintInOut'})
elseif v1 == 'ctweet5' then
cancelTween('blacksback')
setProperty('blacks.alpha',0)
doTweenAlpha('blacksin2','blacks',0.75,25,'circOut')
elseif v1 == 'end' then
endzooming = true
startTween('camgameout','camGame',{zoom = 0.1}, 3,{startDelay = 0.5,ease = 'cubeInOut'})
doTweenAlpha('blackout','black',1,2)
doTweenColor('blackcolor','black','000000',2)
elseif v1 == 'red' then
triggerEvent('Screen Shake','0.4,0.010','0.4,0.00225')
cancelTween('blackkstuff')
setProperty('blackk.alpha',0.75)
doTweenAlpha('blackkstuff','blackk',0,2.5,'quintOut')
elseif v1 == 'blackout' then
setProperty('isCameraOnForcedPos', true)
doTweenAlpha('blacksin3','blacks',0.75,10,'circOut')
startTween('logosn312','camFollow',{x = -1500, y = -3650},15,{ease = 'cubeInOut'})
elseif v1 == 'unblackout' then
doTweenAlpha('blacksin41','blacks',0,1.25,'circOut')
end
end
end

function onTimerCompleted(tag)
if tag == 'thing' then
setProperty('dadGroup.x',-2250)
setProperty('dadGroup.y',-3750)
setProperty('boyfriendGroup.x',-1250)
setProperty('boyfriendGroup.y',-3825)

setProperty('camGame.angle',0)
setProperty('bghill.angle',-90)
setProperty('bgfour.angle',0)
setProperty('bgm.angle',-15)
setProperty('bgclouds.angle',0)
setProperty('bgground.angle',-90)
setProperty('bgfore.angle',-90)

setProperty('bgfore.y',-6650)
setProperty('bgground.y',-6250)
setProperty('bgm.y',getProperty('bgm.y')-500)
setProperty('bgfour.y',getProperty('bgfour.y')-625)
setProperty('bgfore.x',getProperty('bgfore.x')-2300)
setProperty('bgground.x',getProperty('bgground.x')-1350)
setProperty('bgm.x',getProperty('bgm.x')-1000)
setProperty('bgfour.x',getProperty('bgfour.x')-1175)

startTween('zoom2','this',{defaultCamZoom = 0.325},0.5,{startDelay = 0.5/2, ease = 'quartInOut'})
setProperty('cameraSpeed',1000)
setProperty('camFollow.x',-1100)
setProperty('camFollow.y',-2475)
runTimer('end',0.01)


for i = 1,numberof do
setProperty('jnjtweet'..i..'.angle',0)
setProperty('jnjtweet'..i..'.x',getProperty('jnjtweet'..i..'.x')-850)
setProperty('jnjtweet'..i..'.y',getProperty('jnjtweet'..i..'.y')-600)
end
elseif tag == 'end' then
angry = true
ydownoffset = 130/1.5
setProperty('isCameraOnForcedPos', false)
setProperty('cameraSpeed',2)
cameraSetTarget('dad')
elseif tag == 'thing2' then
cameraFlash('camGame','FFFFFF',1)
startTween('zoom2','this',{defaultCamZoom = 0.325},0.5,{startDelay = 0.5/2, ease = 'quartInOut'})
setProperty('cameraSpeed',1000)
setProperty('camFollow.x',0)
setProperty('camFollow.y',0)
runTimer('end2',0.01)

setProperty('dadGroup.x',dadx)
setProperty('dadGroup.y',dady)
setProperty('boyfriendGroup.x',bfx)
setProperty('boyfriendGroup.y',bfy)

setProperty('camGame.angle',0)
setProperty('bghill.angle',0)
setProperty('bgfour.angle',0)
setProperty('bgm.angle',0)
setProperty('bgclouds.angle',0)
setProperty('bgground.angle',0)
setProperty('bgfore.angle',0)

setProperty('bgfore.y', -850)
setProperty('bgground.y', -400)
setProperty('bgfour.y', -775)
setProperty('bgm.y', -850)

setProperty('bgfore.x',getProperty('bgfore.x')+2300)
setProperty('bgground.x',getProperty('bgground.x')+1350)
setProperty('bgm.x',-1400)
setProperty('bgfour.x',750)
setProperty('bgclouds.y',-1200)
setProperty('bgclouds.x',-2150)

for i = 1,numberof do
setProperty('jnjtweet'..i..'.angle',0)
setProperty('jnjtweet'..i..'.x',1250)
setProperty('jnjtweet'..i..'.y',0)
end
for i = 1,7 do
tweet()
end
playAnim('hell','idle2')
elseif tag == 'end2' then
angry = true
ydownoffset = 130
setProperty('isCameraOnForcedPos', false)
setProperty('cameraSpeed',3)
cameraSetTarget('dad')
startTween('ctweet','ctweet1',{angle = 15, y = -1300, x = -950},5.25,{startDelay = 2, ease = 'quintInOut'})
setProperty('black.alpha',0)
end
end


angry = false
function onBeatHit()
if angry then
if curBeat % 4 == 0 then
tweet()
if getProperty('jnjtweet'..numberof..'.y') < -2550 then
angry = false
end
end
end
end

twolines = {1,2,5,10,13,18,21,23,24,25,28,38,57,60}
threelines = {8,9,11,16,19,31,35,40,42,47,50}
fourlines = {7,15,26,29,32,37,43,44,45,48}
fivelines = {22,30,58,59}
sixlines = {36,41}
onelines = {3,4,6,12,14,17,20,27,34,39,46,49,51,52,53,54,55,56}
yoffset = 0
number = 0
ydownoffset = 130
function tweet(direction)
if mustHitSection then
number = getRandomInt(51,60,number)
elseif not mustHitSection then
number = getRandomInt(2,49,number)
end

for i = 1,60 do
if number == twolines[i] then
yoffset = 135.5
elseif number == threelines[i] then
yoffset = 162.5
elseif number == fourlines[i] then
yoffset = 182.5
elseif number == fivelines[i] then
yoffset = 212.5
elseif number == sixlines[i] then
yoffset = 232.5
elseif number == onelines[i] then
yoffset = 110.5
end
end

numberof = numberof+1
makeLuaSprite('jnjtweet'..numberof,'backgrounds/track26/QUOTES/'..number,getProperty('jnjtweet1.x'),getProperty('jnjtweet'..numberof-1 ..'.y')-yoffset)
setScrollFactor('jnjtweet'..numberof,0.4,0.4)
addLuaSprite('jnjtweet'..numberof,false)
setObjectOrder('jnjtweet'..numberof,getObjectOrder('jnjtweet1')+1)

if numeberof == 10 then
numberof = numberof - 1
removeLuaSprite('jnjtweet'..numberof-8)
end

if numberof == 2 then
setProperty('jnjtweet2.y',-305-yoffset)
end

for i = 1,numberof do
doTweenY('jnjtweety'..i,'jnjtweet'..i,getProperty('jnjtweet'..i..'.y')+ydownoffset,1.25,'quintOut')
end

end

function onUpdatePost(elapsed)
if endzooming == true then
setProperty('camZooming',false)
end
end
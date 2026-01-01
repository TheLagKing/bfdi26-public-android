background1 = true
background2 = false
background3 = false

function onSongStart()
cameraFlash('camOther','000000',1)

for i = 0, 3 do
j = (i + 4)

noteTweenAlpha('notelive'..i,i,1,0.01)
noteTweenAlpha('notelive'..j,j,1,0.01)
iPos = _G['defaultPlayerStrumX'..i];
jPos = _G['defaultOpponentStrumX'..i];
if alreadySwapped then
	iPos = _G['defaultOpponentStrumX'..i];
	jPos = _G['defaultPlayerStrumX'..i];
end
noteTweenX('note'..i..'TwnX', i, iPos, 0.001, 'cubeInOut');
noteTweenX('note'..j..'TwnX', j, jPos, 0.001, 'cubeInOut');
if middlescroll == true then
noteTweenX('note'..i..'TwnX',j,iPos, 0.001, 'cubeInOut');
noteTweenX('note'..j..'TwnX',i,jPos, 0.001, 'cubeInOut');
end
end
end

function onCreate() 
triggerEvent('Screen Shake','34,0.001','34,0.0005')
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)
setProperty('camGame.alpha',0)
setProperty('camHUD.alpha',0)
setBlendMode('strumbg','')
doTweenAlpha('camhudhere','camHUD',1,10,'quadOut')
-- 3
makeAnimatedLuaSprite('skyb', 'backgrounds/dotted-line/3/sky waste of space',-275,-300)
addAnimationByPrefix('skyb', 'skyold', 'sky instance 1',24,true)
setScrollFactor('skyb',0.6,0.6)
scaleObject('skyb',0.8,0.8)
setProperty('skyb.alpha',0)
addLuaSprite('skyb',false)

makeLuaSprite('grad', 'backgrounds/dotted-line/3/sky basketball gradient',-275,-85)
setProperty('grad.alpha',0)
addLuaSprite('grad',false)
setBlendMode('grad','multiply')

makeAnimatedLuaSprite('ground', 'backgrounds/dotted-line/3/ground behind',-140,200)
addAnimationByPrefix('ground', 'ground', 'bg back instance 1',24,true)
setScrollFactor('ground',0.7,0.7)
scaleObject('ground',0.8,0.8)
setProperty('ground.alpha',0)
addLuaSprite('ground',true)

makeAnimatedLuaSprite('grass', 'backgrounds/dotted-line/3/tree back 1',750,150)
addAnimationByPrefix('grass', 'grass', 'tree back 1 instance 1',24,true)
setScrollFactor('grass',0.7,0.7)
scaleObject('grass',0.9,0.9)
setProperty('grass.alpha',0)
addLuaSprite('grass',true)

makeAnimatedLuaSprite('grass2', 'backgrounds/dotted-line/3/tree back 2',285,415)
addAnimationByPrefix('grass2', 'grass2', 'tree back 2 instance 1',24,true)
setScrollFactor('grass2',0.7,0.7)
scaleObject('grass2',0.9,0.9)
setProperty('grass2.alpha',0)
addLuaSprite('grass2',true)

makeAnimatedLuaSprite('grass3', 'backgrounds/dotted-line/3/tree back 3',-250,480)
addAnimationByPrefix('grass3', 'grass3', 'tree back 3 instance 1',24,true)
setScrollFactor('grass3',0.7,0.7)
scaleObject('grass3',0.9,0.9)
setProperty('grass3.alpha',0)
addLuaSprite('grass3',true)

makeAnimatedLuaSprite('land', 'backgrounds/dotted-line/3/ground',-350,400)
addAnimationByPrefix('land', 'land', 'ground  floor instance 1',24,true)
setScrollFactor('land',0.7,0.7)
scaleObject('land',0.9,0.9)
setProperty('land.alpha',0)
addLuaSprite('land',true)

makeAnimatedLuaSprite('grass4', 'backgrounds/dotted-line/3/bush front',-275,350)
addAnimationByPrefix('grass4', 'grass4', 'bush front instance 1',24,true)
setScrollFactor('grass4',0.85,0.85)
scaleObject('grass4',0.9,0.9)
setProperty('grass4.alpha',0)
addLuaSprite('grass4',true)
--
-- 2
makeAnimatedLuaSprite('sky', 'backgrounds/dotted-line/2/sky animated',25,-360)
addAnimationByPrefix('sky', 'flowing', 'sky instance 1',24,true)
scaleObject('sky',0.85,0.85)
setProperty('sky.alpha',1)
addLuaSprite('sky',false)

makeAnimatedLuaSprite('water', 'backgrounds/dotted-line/2/water animated',0,150)
addAnimationByPrefix('water', 'flowings', 'Symbol 1 instance 1',24,true)
setScrollFactor('water',0.85,0.85)
setProperty('water.alpha',1)
addLuaSprite('water',false)

makeLuaSprite('shelf', 'backgrounds/dotted-line/2/background',0,0)
setProperty('shelf.alpha',1)
screenCenter('shelf','xy')
addLuaSprite('shelf',false)

makeAnimatedLuaSprite('plant', 'backgrounds/dotted-line/2/plant pot',20,-250)
addAnimationByPrefix('plant', 'flow', 'plant pot instance 1',24,true)
scaleObject('plant',0.9,0.9)
addLuaSprite('plant',false)

makeLuaSprite('chair', 'backgrounds/dotted-line/2/fucking chair',360,50)
setProperty('chair.alpha',1)
scaleObject('chair',0.8,0.8)
addLuaSprite('chair',false)

makeLuaSprite('add', 'backgrounds/dotted-line/2/sprite overlay use add blending mode too',-300,-200)
setProperty('add.alpha',0)
setBlendMode('add','add')
addLuaSprite('add',true)

makeAnimatedLuaSprite('force', 'backgrounds/dotted-line/2/magicstar',350,300)
addAnimationByPrefix('force', 'move', 'Magic Star instance 1',24,true)
setBlendMode('force','add')
setProperty('force.alpha',0)
scaleObject('force',0.8,0.8)
addLuaSprite('force',true)
--
-- 1
makeAnimatedLuaSprite('swirl', 'backgrounds/dotted-line/1/swirl FUCK',0,-200)
addAnimationByPrefix('swirl', 'wee', 'Symbol 10 instance 1',24,true)
setProperty('swirl.alpha',1)
setScrollFactor('swirl',0.9,0.9)
screenCenter('swirl','x')
addLuaSprite('swirl',false)

for i = 1,5 do
makeLuaSprite('star'..i..'', 'backgrounds/dotted-line/1/star',0,-125)
setProperty('star'..i..'.alpha',0.9)
setProperty('star1.color',getColorFromHex('F3AE69'))
setProperty('star2.color',getColorFromHex('0011ff'))
setProperty('star3.color',getColorFromHex('ff1900'))
setProperty('star4.color',getColorFromHex('ff00d1'))
setProperty('star5.color',getColorFromHex('00ff04'))
setScrollFactor('star'..i..'',0.95,0.95)
setBlendMode('star'..i..'','add')
doTweenAlpha('stars'..i..'','star'..i..'',0,1.25)
addLuaSprite('star'..i..'',false)
end
runTimer('starstuff',getRandomInt(2,5))
star()

makeLuaSprite('v', 'backgrounds/oneshot/vignette',0,0)
setProperty('v.alpha',0.001)
setObjectCamera('v','camHUD')
addLuaSprite('v',true)

if not hideCards then
makeLuaSprite('1', 'rendersnlogos/onerender',675,-750)
scaleObject('1',0.65,0.65)
setObjectCamera('1','camHUD')
setProperty('1.alpha',0.001)
addLuaSprite('1',false)

makeLuaSprite('b', 'rendersnlogos/basketballrender',1075,-750)
scaleObject('b',0.65,0.65)
setObjectCamera('b','camHUD')
setProperty('b.alpha',0.001)
addLuaSprite('b',false)

makeLuaSprite('logos', 'rendersnlogos/dottedlinetext',0,0)
scaleObject('logos',0.5,0.5)
screenCenter('logos','xy')
setProperty('logos.x',getProperty('logos.x')+25)
setProperty('logos.alpha',0.001)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',false)
end
end

function onCreatePost()
for i = 0, 3 do
setPropertyFromGroup('strumLineNotes',i,'alpha',0)
end
end

function onTimerCompleted(tag)
if tag == 'starstuff' and background1 == true then
star()
runTimer('starstuff',getRandomInt(1,2))
end
end



function star()
for i = 1,5 do
setProperty('star'..i..'.alpha',0.9)
scaleObject('star'..i..'',getRandomInt(1,2),getRandomInt(1,2))
doTweenAlpha('stars'..i..'','star'..i..'',0,1.25)
doTweenAngle('starss'..i..'','star'..i..'',getRandomInt(90,360),2,'quadOut')
setProperty('star'..i..'.x',getRandomInt(-530,1400))
setProperty('star'..i..'.y',getRandomInt(-325,300))

doTweenY('stary'..i..'','star'..i..'',125,getRandomInt(1.25,2.5),'quadOut')
doTweenY('stary2'..i..'','star'..i..'.scale',0.5,2,'quadOut')

doTweenX('starz'..i..'','star'..i..'',450,getRandomInt(1.5,3),'quadOut')
doTweenX('starz2'..i..'','star'..i..'.scale',0.5,2,'quadOut')
end
end
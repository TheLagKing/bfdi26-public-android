paper = true
tpot = false
cakealpha = 1

characterArray = {'s','8s','ru','rufg1','rufg2','tsfg','ts','tsmg'}

function onCreate() 
setProperty('camGame.bgColor', getColorFromHex('8ECA73'))
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeLuaSprite('tpotSKY','backgrounds/hey-two/tpot/SKY',-1750,-900)
setScrollFactor('tpotSKY',0.25,0.25)
addLuaSprite('tpotSKY',false)

makeLuaSprite('tpotHills','backgrounds/hey-two/tpot/HILLS',-1150,325)
setScrollFactor('tpotHills',0.75,0.75)
addLuaSprite('tpotHills',false)

makeLuaSprite('tpotFloor','backgrounds/hey-two/tpot/GROUND',-850,-50)
addLuaSprite('tpotFloor',false)

-- bfb
makeLuaSprite('sky', 'backgrounds/hey-two/bg1/sky burnt bg',-350,-50)
setProperty('sky.alpha',1)
setScrollFactor('sky',0.5,0.5)
addLuaSprite('sky',false)

makeLuaSprite('hill', 'backgrounds/hey-two/bg1/hills burnt bg',0,625)
setProperty('hill.alpha',1)
setScrollFactor('hill',0.9,0.9)
addLuaSprite('hill',false)

makeLuaSprite('floor','backgrounds/hey-two//bg1/ground burnt bg',250,685)
addLuaSprite('floor')
setScrollFactor('floor',0.995,0.995)

-- split - characters
makeAnimatedLuaSprite('m', 'backgrounds/hey-two/bg1/three musketeers',1760,540)
setScrollFactor('m',0.995,0.995)
addAnimationByPrefix('m', 'bop', 'three musketeers instance 1',24,false)
addLuaSprite('m',false)

makeAnimatedLuaSprite('sp', 'backgrounds/hey-two/bg1/split speaker soul',1125,825)
setScrollFactor('sp',0.995,0.995)
addAnimationByPrefix('sp', 'bop3', 'speaker bg instance 1',24,false)
addLuaSprite('sp',false)

makeAnimatedLuaSprite('t', 'backgrounds/hey-two/bg1/oh my gordita',2200,1000)
setScrollFactor('t',1.05,1.05)
addAnimationByPrefix('t', 'bop2', 'taco bg instance 1',24,false)
addLuaSprite('t',true)

-- tpot - characters - bg
makeAnimatedLuaSprite('s', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/THE S/THE S SHEET',800,350)
setScrollFactor('s',0.975,0.975)
addAnimationByPrefix('s', 'bop', 'THE S SHEET instance 1',24,false)
addLuaSprite('s',false)

makeAnimatedLuaSprite('8s', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/TEAM 8S/TEAM8S SHEET',665,350)
setScrollFactor('8s',0.975,0.975)
addAnimationByPrefix('8s', 'bop', 'TEAM8S SHEET instance 1',24,false)
addLuaSprite('8s',false)

makeAnimatedLuaSprite('ts', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/TSTOE/robot_flower_you_are_so_alone_and_sad',1230,365)
setScrollFactor('ts',0.9,0.9)
addAnimationByPrefix('ts', 'bop', 'ROBOT FLOWER BG instance 1',24,false)
addLuaSprite('ts',false)

makeAnimatedLuaSprite('ru', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/R U OK/RUOK BG SHEET',485,280)
setScrollFactor('ru',0.975,0.975)
addAnimationByPrefix('ru', 'bop', 'RUOK BG SHEET instance 1',24,false)
addLuaSprite('ru',false)

makeAnimatedLuaSprite('jn', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/JUST NOT/JUST NOT BG SHEET',480,270)
setScrollFactor('jn',0.975,0.975)
addAnimationByPrefix('jn', 'bop', 'JUST NOT BG SHEET instance 1',24,true)
addLuaSprite('jn',false)

makeAnimatedLuaSprite('pbg', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/DEATH PACT/DEATH PACT BH GLOW',1200,-200)
setScrollFactor('pbg',0.975,0.975)
addAnimationByPrefix('pbg', 'bop', 'BLACK HOLE DEATH PACT GLOW instance 1',24,true)
addLuaSprite('pbg',false)
setBlendMode('pbg','add')

makeAnimatedLuaSprite('pb', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/DEATH PACT/DEATH PACT BH',1850,-100)
setScrollFactor('pb',0.975,0.975)
addAnimationByPrefix('pb', 'bop', 'BLACK HOLE DEATH PACT BG instance 1',24,true)
addLuaSprite('pb',false)

makeAnimatedLuaSprite('p', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/DEATH PACT/DEATH PACT BG SHEET',480,235)
setScrollFactor('p',0.975,0.975)
addAnimationByPrefix('p', 'bop', 'DEATH PACT BG SHEET instance 1',24,true)
addLuaSprite('p',false)
--

-- mg
makeAnimatedLuaSprite('tsmg', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/TSTOE/TSTOE MG SHEET',225,-250)
addAnimationByPrefix('tsmg', 'bop', 'TSTOE MG SHEET instance 1',24,false)
addLuaSprite('tsmg',false)

makeAnimatedLuaSprite('jnmg1', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/JUST NOT/JUST NOT MG SHEET1',200,-250)
addAnimationByPrefix('jnmg1', 'bop', 'JUST NOT MG SHEET instance 1',24,true)
addLuaSprite('jnmg1',false)

makeAnimatedLuaSprite('jnmg2', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/JUST NOT/JUST NOT MG SHEET2',200,-250)
addAnimationByPrefix('jnmg2', 'bop', 'JUST NOT MG SHEET instance 1',24,true)
addLuaSprite('jnmg2',false)

makeAnimatedLuaSprite('jnmg3', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/JUST NOT/JUST NOT MG SHEET3',200,-250)
addAnimationByPrefix('jnmg3', 'bop', 'JUST NOT MG SHEET instance 1',24,true)
addLuaSprite('jnmg3',false)

makeAnimatedLuaSprite('pmg', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/DEATH PACT/DEATH PACT MG SHEET',30,-250)
scaleObject('pmg',1.5,1.5)
addAnimationByPrefix('pmg', 'bop', 'DEATH PACT MG SHEET instance 1',24,true)
addLuaSprite('pmg',false)
--

-- fg
makeAnimatedLuaSprite('rufg1', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/R U OK/RUOK FG SHEET1',375,710)
setScrollFactor('rufg1',1.05,1.05)
addAnimationByPrefix('rufg1', 'bop', 'RUOK FG SHEET instance 1',24,false)
addLuaSprite('rufg1',true)

makeAnimatedLuaSprite('rufg2', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/R U OK/RUOK FG SHEET2',375,710)
setScrollFactor('rufg2',1.05,1.05)
addAnimationByPrefix('rufg2', 'bop', 'RUOK FG SHEET instance 1',24,false)
addLuaSprite('rufg2',true)

makeAnimatedLuaSprite('tsfg', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/TSTOE/TSTOE FG SHEET',125,720)
scaleObject('tsfg',1.5,1.5)
setScrollFactor('tsfg',1.05,1.05)
addAnimationByPrefix('tsfg', 'bop', 'TSTOE FG SHEET instance 1',24,false)
addLuaSprite('tsfg',true)

makeAnimatedLuaSprite('jnfg', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/JUST NOT/JUST NOT FG SHEET',-175,720)
scaleObject('jnfg',1.5,1.5)
setScrollFactor('jnfg',1.05,1.05)
addAnimationByPrefix('jnfg', 'bop', 'JUST NOT FG SHEET instance 1',24,true)
addLuaSprite('jnfg',true)

makeAnimatedLuaSprite('pfg', 'backgrounds/hey-two/tpot/BG DISTRIBUTIONS/DEATH PACT/DEATH PACT FG SHEET',-192.5,730)
scaleObject('pfg',1.5,1.5)
setScrollFactor('pfg',1.05,1.05)
addAnimationByPrefix('pfg', 'bop', 'DEATH PACT FG SHEET instance 1',24,true)
addLuaSprite('pfg',true)

for _, teamswap in ipairs({'8s','ru','ts','pbg','pb','p','tsmg','pmg','rufg1','rufg2','tsfg','pfg'}) do startTween('teamswitch'..teamswap, teamswap..'.colorTransform', {redOffset = 255, greenOffset = 255, blueOffset = 255}, 0.75,{ease = 'quadOut'}) end
for _, teamswap in ipairs({'8s','ru','ts','pbg','pb','p','tsmg','pmg','rufg1','rufg2','tsfg','pfg','jn','jnfg','jn','s','jnmg1','jnmg2','jnmg3'}) do setProperty(teamswap..'.alpha',0.001) end
--

makeLuaSprite('black', '', 0, 0)
setScrollFactor('black', 0, 0)
makeGraphic('black',1,1,'ffffff')
setProperty('black.alpha',1)
scaleObject('black',1280*2,720*2)
addLuaSprite('black',false)
screenCenter('black', 'xy')
setObjectOrder('black',19)

makeLuaSprite('paper','backgrounds/hey-two/paper',0,0)
setBlendMode('paper','multiply')
scaleObject('paper',2,2)
setProperty('paper.visible',true)
setProperty('paper.alpha',0.5)
addLuaSprite('paper',true)
setObjectCamera('paper','other')

makeLuaSprite('transition', '',-1280,0);
makeGraphic('transition',1,1,'000000')
scaleObject('transition',1280,720)
addLuaSprite('transition',false);
setObjectCamera('transition', 'camHUD')

makeLuaSprite('flash', '', 0, 0)
setScrollFactor('flash', 0, 0)
makeGraphic('flash',1,1,'ffffff')
scaleObject('flash',1280,720)
setProperty('flash.alpha',0)
setBlendMode('flash','add')
addLuaSprite('flash',true)
setObjectCamera('flash','other')
screenCenter('flash', 'xy')
if not hideCards then
makeAnimatedLuaSprite('logos', 'rendersnlogos/hey two titlecard',0,0)
scaleObject('logos',0.65,0.65)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','other')
addLuaSprite('logos',true)
end

makeLuaSprite('black2', '', 0, 0)
setScrollFactor('black2', 0, 0)
makeGraphic('black2',1,1,'000000')
setProperty('black2.alpha',1)
setObjectCamera('black2','other')
scaleObject('black2',1280,720)
addLuaSprite('black2',false)
screenCenter('black2', 'xy')
end

function onCreatePost()
setProperty('gf.visible',false)
setProperty('t.visible',false)
setScrollFactor('gfGroup',1,1)
setProperty('camHUD.visible',false)
end

function onEvent(name,v1,v2)
if name == 'Trigger' and v1 == 'renderin' then
setProperty('logos.alpha',1)
addAnimationByPrefix('logos', 'title', 'hey two title instance 1',24,false)
paper = true
elseif name == 'Trigger' and v1 == 'renderout' then
setProperty('flash.alpha',1)
setProperty('camHUD.visible',true)
setObjectCamera('logos','camHUD')
startTween('logo','logos',{alpha = 0}, 0.5,{startDelay = 2.5, ease = 'quadOut'})
startTween('flashwhite2','flash',{alpha = 0}, 1.5,{startDelay = 0.25, ease = 'quadOut'})
removeLuaSprite('black2')
elseif name == 'Trigger' and v1 == 'zoomin' then
triggerEvent('Alt Idle Animation','dad','-alt')
triggerEvent('Alt Idle Animation','boyfriend','-alt')
doTweenZoom('camgoin','camGame',0.915,0.5,'elasticOut')
setProperty('defaultCamZoom',0.915)
elseif name == 'Trigger' and v1 == 'lockinplace' then
doTweenX('camX3', 'camFollow',1625,1.75,'cubeInOut')
doTweenY('camY4', 'camFollow',950,3,'cubeInOut')
doTweenZoom('camgoout','camGame',0.8,2.25,'cubeInOut')
setProperty('defaultCamZoom',0.8)
setProperty('isCameraOnForcedPos', true)
setProperty('camZooming',false)
elseif name == 'Trigger' and v1 == 'tpot' then
cancelTween('camX3')
cancelTween('camY4')
startTween('flashwhite','flash',{alpha = 1}, 1,{startDelay = 1.725, ease = 'quadOut'})
startTween('zoom','camGame',{zoom = 3}, 3,{startDelay = 0.1, ease = 'cubeInOut'})
doTweenX('camX2', 'camFollow',1750,2,'cubeInOut')
doTweenY('camY1', 'camFollow',1050,2,'cubeInOut')


alreadySwapped = true
for i = 0, 3 do
j = (i + 4)

iPos = _G['defaultPlayerStrumX'..i];
jPos = _G['defaultOpponentStrumX'..i];
if alreadySwapped then
iPos = _G['defaultOpponentStrumX'..i];
jPos = _G['defaultPlayerStrumX'..i];
end
noteTweenX('note'..i..'TwnX', i, iPos, 1.25, 'cubeInOut');
noteTweenX('note'..j..'TwnX', j, jPos, 1.25, 'cubeInOut');
if middlescroll == true then
noteTweenX('note'..i..'TwnX',j,iPos, 1.25, 'cubeInOut');
noteTweenX('note'..j..'TwnX',i,jPos, 1.25, 'cubeInOut');
end
end
elseif name == 'Trigger' and v1 == 'tpotstart' then
for _, backgroundsprites in ipairs({'sky','hill','floor','m','t','black','paper','transition','sp'}) do
removeLuaSprite(backgroundsprites)
setProperty('gf.visible',false)
setProperty('s.alpha',1)
setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x')-30)
end
cancelTween('camX2')
cancelTween('camY1')
setProperty('isCameraOnForcedPos', true)
doTweenX('camX6', 'camFollow',1725,1.75,'cubeInOut')
doTweenY('camY8', 'camFollow',905,1.5,'cubeInOut')
setProperty('boyfriendGroup.y',getProperty('boyfriendGroup.y')+35)
elseif name == 'Trigger' and v1 == 'bgcswitch1' then
startTween('teamabouttoswitch', 's.colorTransform', {redOffset = 255, greenOffset = 255, blueOffset = 255}, 0.75,{ease = 'quadOut'})
elseif name == 'Trigger' and v1 == '8s' then
removeLuaSprite('s')
setProperty('8s.alpha',1)
startTween('teamswitch', '8s.colorTransform', {redOffset = 0, greenOffset = 0, blueOffset = 0}, 1,{ease = 'quadOut'})
triggerEvent('Screen Shake','0.25,0.005','0,0')
elseif name == 'Trigger' and v1 == 'bgcswitch2' then
startTween('teamabouttoswitch2', '8s.colorTransform', {redOffset = 255, greenOffset = 255, blueOffset = 255}, 0.75,{ease = 'quadOut'})
elseif name == 'Trigger' and v1 == 'ruok' then
triggerEvent('Screen Shake','0.25,0.005','0,0')
removeLuaSprite('8s')
for _, teamswap in ipairs({'ru','rufg1','rufg2'}) do setProperty(teamswap..'.alpha',1) startTween('teamswitch'..teamswap, teamswap..'.colorTransform', {redOffset = 0, greenOffset = 0, blueOffset = 0}, 1,{ease = 'quadOut'}) end
elseif name == 'Trigger' and v1 == 'bgcswitch3' then
for _, teamswap in ipairs({'ru','rufg1','rufg2'}) do startTween('teamswitch'..teamswap, teamswap..'.colorTransform', {redOffset = 255, greenOffset = 255, blueOffset = 255}, 0.75,{ease = 'quadOut'}) end
elseif name == 'Trigger' and v1 == 'tstoe' then
triggerEvent('Screen Shake','0.25,0.005','0,0')
for _, teamswap in ipairs({'rufg1','rufg2'}) do removeLuaSprite(teamswap) end
for _, teamswap in ipairs({'ru','ts','tsmg','tsfg'}) do setProperty(teamswap..'.alpha',1) startTween('teamswitch'..teamswap, teamswap..'.colorTransform', {redOffset = 0, greenOffset = 0, blueOffset = 0}, 1,{ease = 'quadOut'}) end
elseif name == 'Trigger' and v1 == 'twofly' then
tpot = true
setProperty('dadGroup.y',getProperty('dadGroup.y')-50)
for _, teamswap in ipairs({'ru','ts','tsmg','tsfg'}) do removeLuaSprite(teamswap) end
for _, teamswap in ipairs({'jnfg','jn','jnmg1','jnmg2','jnmg3'}) do setProperty(teamswap..'.alpha',1) end
elseif name == 'Trigger' and v1 == 'bgcswitch4' then
for _, teamswap in ipairs({'jnfg','jn','jnmg1','jnmg2','jnmg3'}) do startTween('teamswitch'..teamswap, teamswap..'.colorTransform', {redOffset = 255, greenOffset = 255, blueOffset = 255}, 0.75,{ease = 'quadOut'}) end
elseif name == 'Trigger' and v1 == 'pact' then
triggerEvent('Screen Shake','0.25,0.005','0,0')
paper = true
cakealpha = 2
for _, teamswap in ipairs({'jnfg','jn','jnmg1','jnmg2','jnmg3'}) do removeLuaSprite(teamswap) end
for _, teamswap in ipairs({'p','pmg','pfg','pb','pbg'}) do setProperty(teamswap..'.alpha',1) startTween('teamswitch'..teamswap, teamswap..'.colorTransform', {redOffset = 0, greenOffset = 0, blueOffset = 0}, 1,{ease = 'quadOut'}) end
elseif name == 'Transition' then
setProperty('transition.x',-1280)
doTweenX('part1', 'transition',0,v1, 'linear')
runTimer('trans',0.325)
paper = false
elseif name == 'Trigger' and v1 == 'focusbf' then
cameraSetTarget('bf')
elseif name == 'Trigger' and v1 == 'focusdad' then
cameraSetTarget('dad')
elseif name == 'Trigger' and v1 == 'drop' then
startTween('zoom2','camGame',{zoom = 3.1}, 4,{startDelay = 0.75, ease = 'cubeInOut'})
setProperty('camZooming',false)
elseif name == 'Trigger' and v1 == 'hype' then
cancelTween('zoom2')
cameraFlash('camGame','FFFFFF',1)
elseif name == 'Trigger' and v1 == 'whiteout' then
setProperty('camZooming',false)
setProperty('flash.visible',true)
setProperty('flash.alpha',0)
startTween('camgameout','camGame',{zoom = 0.1}, 2,{startDelay = 0.25,ease = 'cubeInOut'})
doTweenAlpha('blackout2','flash',1,1)
end
end

function onTweenCompleted(tag)
if tag == 'part1' then
setProperty('black.alpha',0)
setProperty('paper.visible',false)
setProperty('gf.visible',true)
setProperty('t.visible',true)
cancelTween(count..'spin')
removeLuaSprite(count)
elseif tag == count..'alpha' then
cancelTween(count..'spin')
removeLuaSprite(count)
end
end

function onTimerCompleted(tag)
if tag == 'trans' then
doTweenX('transitiondie','transition',1280,0.2)
for i = 0, 3 do
j = (i + 4)

iPos = _G['defaultPlayerStrumX'..i];
jPos = _G['defaultOpponentStrumX'..i];
if alreadySwapped then
iPos = _G['defaultOpponentStrumX'..i];
jPos = _G['defaultPlayerStrumX'..i];
end
noteTweenX('note'..i..'TwnX', i, iPos, 1.25, 'cubeInOut');
noteTweenX('note'..j..'TwnX', j, jPos, 1.25, 'cubeInOut');
if middlescroll == true then
noteTweenX('note'..i..'TwnX',j,iPos, 1.25, 'cubeInOut');
noteTweenX('note'..j..'TwnX',i,jPos, 1.25, 'cubeInOut');
end
end
end
end

local cake = {'cake', 'cakenormal', 'cakev', 'cheese','icecream','icecube','yoylefake'}
local count = 0
local setcake = 1

function createCake()
count = count + 1
setcake = getRandomInt(1,#cake,setcake)
makeLuaSprite(count, 'soundtrays/'..cake[setcake]..'/bar_10',getRandomInt(-400,2700),getRandomInt(-150,1050))
setObjectOrder(count,20)
addLuaSprite(count,false)
-- tweens
scaleObject(count,1.5,1.5)
setScrollFactor(count,0.75,0.75)
doTweenX(count..'sizex',''..count..'.scale',0.75,1,'elasticOut')
doTweenY(count..'sizey',''..count..'.scale',0.75,1,'circOut')
doTweenAngle(count..'spin',count,getRandomInt(360,720),getRandomInt(7.5,10),'circOut')
doTweenAlpha(count..'alpha', count, 0, cakealpha, 'circOut')
--
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
if not isSustainNote and paper == true and not lowQuality then
cakechance = getRandomInt(1,2)
if cakechance == 1 then
createCake()
end
end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
if not isSustainNote and paper == true and not lowQuality then
cakechance = getRandomInt(1,2)
if cakechance == 1 then
createCake()
end
end
end

function onUpdatePost(elapsed)
songPos = getSongPosition()
if tpot == true then
setProperty('dadGroup.x', getProperty('dadGroup.x') + 4 * math.cos(curDecBeat / 4 * math.pi) * elapsed * 60)
setProperty('dadGroup.y', getProperty('dadGroup.y') + 4 * math.sin(curDecBeat / 4 * math.pi) * elapsed * 80)
end
end

function onBeatHit()
if curBeat % 2 == 0 then
objectPlayAnimation('m','bop')
objectPlayAnimation('t','bop2')
objectPlayAnimation('sp','bop3')
for i = 0, #characterArray do
objectPlayAnimation(characterArray[i],'bop')
end
end
end
local start = false
local focus = false
local dbmove = nil
local prankchange = 1
local Cutscene = true

function onStartCountdown()    
    if Cutscene and yoylefakeStart then
	runHaxeCode([[yoylefakes.delayAndStart();]])
	runTimer('endvideo',30)
    return Function_Stop;
    end
end

function onSongStart()
setProperty('bars.alpha',0)
setProperty('camZooming',false)
setProperty('iconP1.visible',false)
setProperty('iconP2.visible',false)
setProperty('healthBar.visible',false)
setProperty('scoreTxt.visible',false)
setProperty('botplayTxt.visible',false)
setProperty('timeTxt.visible',false)
setProperty('reddot.visible',false)
setProperty('redline.visible',false)
setProperty('camHUD.alpha',0)

setProperty('dad.x',getProperty('dad.x')+150)
setProperty('boyfriend.x',getProperty('boyfriend.x')-150)
end

function onCreate()
-- background shit
makeLuaSprite('h', 'backgrounds/yoylefake/happy bg',-1000,-400)
scaleObject('h',2,2)
setScrollFactor('h',0.15,0.15)
setProperty('h.alpha',1)
addLuaSprite('h',false)

makeLuaSprite('sky', 'backgrounds/yoylefake/sky whitescape',-400,50)
setScrollFactor('sky',0.35,0.35)
setProperty('sky.alpha',0.001)
addLuaSprite('sky',false)

makeLuaSprite('fy', 'backgrounds/yoylefake/ground whitescape',100,1100)
setProperty('fy.alpha',0.001)
addLuaSprite('fy',false)
--bg 1
makeLuaSprite('bg1sky', 'backgrounds/yoylefake/sky buh',500,770)
setProperty('bg1sky.alpha',1)
scaleObject('bg1sky',1.4,1.4)
screenCenter('bg1sky','xy')
setScrollFactor('bg1sky',0,0)
addLuaSprite('bg1sky',false)

createInstance('bg1c', 'flixel.addons.display.FlxBackdrop', {nil, 0x01, 0})
loadGraphic('bg1c', 'backgrounds/yoylefake/cloude')
setProperty('bg1c.x',-200)
setProperty('bg1c.y',-200)
setProperty('bg1c.velocity.x',35)
setProperty('bg1c.alpha',1)
setScrollFactor('bg1c',0.1,0.1)
addLuaSprite('bg1c',false)

makeLuaSprite('bg1ef', 'backgrounds/yoylefake/eifell tower',325,25)
scaleObject('bg1ef',1,1)
scaleObject('bg1ef',1.3,1.3)
setProperty('bg1ef.alpha',1)
setScrollFactor('bg1ef',0.35,0.35)
addLuaSprite('bg1ef',false)

makeLuaSprite('bg1grass2', 'backgrounds/yoylefake/grasse 2',-250,775)
scaleObject('bg1grass2',1,1)
setProperty('bg1grass2.alpha',1)
setScrollFactor('bg1grass2',0.5,0.5)
addLuaSprite('bg1grass2',false)

makeLuaSprite('bg1grass', 'backgrounds/yoylefake/grasse 1',200,1370)
scaleObject('bg1grass',1,1)
setProperty('bg1grass.alpha',1)
addLuaSprite('bg1grass',false)

makeLuaSprite('det','backgrounds/yoylefake/de toe nay tor',1000,1425)
addLuaSprite('det',false)
setProperty('det.alpha',1)

makeLuaSprite('brc','backgrounds/yoylefake/BRC fuhd uhh',585,1085)
addLuaSprite('brc',false)
setProperty('brc.alpha',1)
--

makeLuaSprite('lava', 'backgrounds/yoylefake/lava sea',-350,450)
setScrollFactor('lava',0.2,0.2)
setProperty('lava.alpha',0.001)
scaleObject('lava',1.1,1.1)
addLuaSprite('lava',false)

makeAnimatedLuaSprite('michael', 'backgrounds/yoylefake/nightmare island',175,75)
setScrollFactor('michael',0.2,0.2)
addAnimationByPrefix('michael', 'burn', 'Island instance 1',24,true)
setProperty('michael.alpha',0.001)
addLuaSprite('michael',false)

makeAnimatedLuaSprite('fire3', 'backgrounds/yoylefake/fire',-425,90)
addAnimationByPrefix('fire3', 'flames', 'fire',20,true)
scaleObject('fire3',1.5,1.5)
setScrollFactor('fire3',0.5,0.5)
setProperty('fire3.alpha',0.001)
setProperty('fire3.visible',false)
setBlendMode('fire3','add')
addLuaSprite('fire3',false)

makeLuaSprite('center', 'backgrounds/yoylefake/recovery',1000,100)
setScrollFactor('center',0.6,0.6)
setProperty('center.alpha',0.001)
addLuaSprite('center',false)

makeLuaSprite('center2', 'backgrounds/yoylefake/recovery',1500,100)
setScrollFactor('center2',0.59,0.59)
setProperty('center2.alpha',0.001)
addLuaSprite('center2',false)

makeLuaSprite('red', '',125,1500)
makeGraphic('red',1,1,'D40202')
scaleObject('red',2850,270)
setProperty('red.alpha',0.001)
addLuaSprite('red',false)

makeLuaSprite('white', '',125,1500)
makeGraphic('white',1,1,'FF0000')
scaleObject('white',2850,270)
setBlendMode('white','add')
setProperty('white.alpha',0.001)
addLuaSprite('white',false)

makeLuaSprite('table', 'backgrounds/yoylefake/table',1250,1400)
setProperty('table.alpha',0.001)
scaleObject('table',0.8,0.8)
addLuaSprite('table',false)

makeLuaSprite('tvf','',425, 250)
setScrollFactor('tvf',0.75,0.75)
makeGraphic('tvf',1,1,'000000')
setProperty('tvf.alpha',0.001)
scaleObject('tvf',1850,1200)
addLuaSprite('tvf',false)

makeLuaSprite('frame','backgrounds/yoylefake/pranks0001',380, 300)
setScrollFactor('frame',0.75,0.75)
setProperty('frame.alpha',0.001)
addLuaSprite('frame',false)

makeLuaSprite('tv','backgrounds/yoylefake/tv frame',350,250)
setScrollFactor('tv',0.75,0.75)
setProperty('tv.alpha',0.001)
addLuaSprite('tv',false)

makeLuaSprite('platform', 'backgrounds/yoylefake/platform',810,1615)
setProperty('platform.alpha',0.001)
addLuaSprite('platform',false)

makeLuaSprite('platform2', 'backgrounds/yoylefake/platform',1910,1615)
setProperty('platform2.alpha',0.001)
addLuaSprite('platform2',false)

makeLuaSprite('center3', 'backgrounds/yoylefake/recovery',500,-500)
setProperty('center3.alpha',0.001)
scaleObject('center3',1.5,1.5)
addLuaSprite('center3',true)

makeAnimatedLuaSprite('fire', 'backgrounds/yoylefake/fire',-225,690)
addAnimationByPrefix('fire', 'flames', 'fire',16,true)
scaleObject('fire',1.5,1.5)
setScrollFactor('fire',0.75,0.75)
setProperty('fire.alpha',0.001)
setProperty('fire.visible',false)
setBlendMode('fire','add')
addLuaSprite('fire',true)

if not hideCards then
makeLuaSprite('fire2', 'rendersnlogos/yoylefaketitle',0,0)
scaleObject('fire2',0.65,0.65)
screenCenter('fire2','xy')
setObjectCamera('fire2','camHUD')
setProperty('fire2.alpha',0.001)
addLuaSprite('fire2',false)
end

makeLuaSprite('blackk', '', 0, 0)
setScrollFactor('blackk', 0, 0)
makeGraphic('blackk',1,1,'FF0000')
setBlendMode('blackk','multiply')
setProperty('blackk.alpha',0)
setObjectCamera('blackk','other')
scaleObject('blackk',1280*2,720*2)
addLuaSprite('blackk',true)
screenCenter('blackk', 'xy')

makeLuaSprite('flash', '', 0, 0);
makeGraphic('flash',1,1,'ffffff')
scaleObject('flash',1280,720)
setProperty('flash.alpha',0)
setBlendMode('flash', 'add')
setObjectCamera('flash', 'other')
screenCenter('flash','xy')
addLuaSprite('flash', true);

makeLuaSprite('blacks', '', 0, 0)
setScrollFactor('blacks', 0, 0)
makeGraphic('blacks',1,1,'000000')
setProperty('blacks.alpha',0)
scaleObject('blacks',1280*3,720*3)
addLuaSprite('blacks',false)
screenCenter('blacks', 'xy')
setObjectOrder('blacks',getObjectOrder('dadGroup')-2)

makeLuaSprite('black', '', 0, 0)
setScrollFactor('black', 0, 0)
makeGraphic('black',1280,720,'000000')
setProperty('black.alpha',1)
setObjectCamera('black','camGame')
addLuaSprite('black',true)
scaleObject('black',2,2)
screenCenter('black', 'xy')

makeLuaSprite('video','backgrounds/yoylefake/yt intro',0,0)
setProperty('video.color',getColorFromHex('000000'))
scaleObject('video',0.6,0.6)
setObjectCamera('video','other')
screenCenter('video','xy')
addLuaSprite('video',true)

end

function onCreatePost()
if shadersEnabled then
initLuaShader('void')
initLuaShader('lava')
setSpriteShader('h','void')
end
end


function onSectionHit(elapsed)
if not mustHitSection and focus == true then
setProperty('defaultCamZoom',0.575)
elseif mustHitSection and focus == true then
setProperty('defaultCamZoom',0.7)
end
end

function onUpdatePost()
songPos = getSongPosition()
if start == true then
doTweenAlpha('imthealpha','fire',0.55+0.15*math.sin((songPos/3000) * (bpm/30) *1),0.01)
doTweenAlpha('imthealpha2','fire3',0.65+0.25*math.sin((songPos/4000) * (bpm/60) *1),0.01)
end

if shadersEnabled then
setShaderFloat('h','iTime',os.clock())
setShaderFloat('sky','iTime',os.clock())
end

if start == true then
noteTweenX("NoteMove",0,795, 0.001)
noteTweenX("NoteMovebb",1,1015, 0.001)
noteTweenX("NoteMovebbb",2,1240, 0.001)
noteTweenX("NoteMovebbbb",3,1450, 0.001)
end
if dbmove == 0 then
setProperty('dad.x',2000)
setProperty('dad.y',950)
triggerEvent('Alt Idle Animation','dad','')
elseif dbmove == 1 then
setProperty('dad.x',1680)
setProperty('dad.y',1165)
triggerEvent('Alt Idle Animation','dad','-left')
elseif dbmove == 2 then
setProperty('dad.x',2375)
setProperty('dad.y',1150)
triggerEvent('Alt Idle Animation','dad','-right')
elseif dbmove == 3 then
dbmove = 0
end
end

function onEvent(name,v1,v2)
if name == 'Trigger' and v1 == 'yoylefake' then
start = true
focus = true
doTweenY('recoveryy','center',getRandomInt(1500,2000),getRandomInt(2,5),'quadIn')
doTweenAngle('recoveryy2','center',getRandomInt(360,1080),getRandomInt(5,10),'cubeInOut')
doTweenY('recoveryy4','center2',getRandomInt(1500,2000),getRandomInt(2,5),'quadIn')
doTweenAngle('recoveryy5','center2',getRandomInt(360,1080),getRandomInt(5,10),'cubeInOut')
doTweenY('recoveryy6','center3',getRandomInt(1500,2000),getRandomInt(2,5),'quadIn')
doTweenAngle('recoveryy7','center3',getRandomInt(360,1080),getRandomInt(5,10),'cubeInOut')
elseif name == 'Trigger' and v1 == 'oldback' then
focus = false

setProperty('center.alpha',0)
setProperty('center2.alpha',0)
setProperty('center3.alpha',0)
elseif name == 'Trigger' and v1 == 'thing' then
if shadersEnabled == false then
loadGraphic('h','backgrounds/yoylefake/noshader')
else
setSpriteShader('h','lava')
end
elseif name == 'Trigger' and v1 == 'flashandstop' then
start = true
elseif name == 'Trigger' and v1 == 'backsturned' then
for _, hudout2 in ipairs({'bars','center','center2','center3'}) do doTweenAlpha('backturned'..hudout2,hudout2,1,1.25,'circOut') end
doTweenAlpha('baescoemin','bars',1,1.25,'circOut')
elseif name == 'Change Character' and v2 == 'bubbehind' then
dbmove = 0
runTimer('changestuff',5)
elseif name == 'Change Character' and v2 == 'bubperspec' then
dbmove = nil
setProperty('dad.x',700)
setProperty('dad.y',1300)
triggerEvent('Play Animation','idle','dad')
triggerEvent('Alt Idle Animation','dad','')
end
end

function onTweenCompleted(tag)
if tag == 'dbdiefornow' then
setProperty('dad.scale.x',1.15)
setProperty('dad.scale.y',1.15)
doTweenX('dadgoback','dad.scale',1,0.5,'circOut')
doTweenY('dadgoback2','dad.scale',1,0.5,'circOut')
doTweenAlpha('dbcomeback','dad',1,0.25,'elasticOut')
dbmove = dbmove + 1
updateDB()
elseif tag == 'recoveryy' then
cancelTween('recoveryy2')
setProperty('center.angle',0)
setProperty('center.y',-100)
setProperty('center.x',getRandomInt(-100,2400))
doTweenY('recoveryy','center',getRandomInt(1500,2000),getRandomInt(2,5),'quadIn')
doTweenAngle('recoveryy2','center',getRandomInt(360,1080),getRandomInt(5,10),'cubeInOut')
elseif tag == 'recoveryy4' then
cancelTween('recoveryy5')
setProperty('center2.angle',0)
setProperty('center2.y',-100)
setProperty('center2.x',getRandomInt(-100,2400))
doTweenY('recoveryy4','center2',getRandomInt(1500,2000),getRandomInt(2,5),'quadIn')
doTweenAngle('recoveryy5','center2',getRandomInt(360,1080),getRandomInt(5,10),'cubeInOut')
elseif tag == 'recoveryy6' then
cancelTween('recoveryy7')
setProperty('center3.angle',0)
setProperty('center3.y',-500)
setProperty('center3.x',getRandomInt(500,2500))
doTweenY('recoveryy6','center3',getRandomInt(1900,2300),getRandomInt(2,5),'quadIn')
doTweenAngle('recoveryy7','center3',getRandomInt(360,1080),getRandomInt(5,10),'cubeInOut')
end
end

function updateDB()
if dbmove == 0 then
triggerEvent('Play Animation','idle','dad') 
elseif dbmove == 1 then
triggerEvent('Play Animation','idle-left','dad') 
elseif dbmove == 2 then
triggerEvent('Play Animation','idle-right','dad') 
end
end

function onBeatHit()
if curBeat % 8 == 0 then
if getProperty('red.alpha') >0.1 then
cancelTween('whitestuff')
setProperty('white.alpha',0.25)
doTweenAlpha('whitestuff','white',0,1.25,'circOut')
end
end
end

function Prankchange()
startTween('prankswap','frame.colorTransform', {redOffset = 255, greenOffset = 255, blueOffset = 255}, 0.75,{ease = 'quadOut'})
startTween('prankswap2','frame.scale', {y = 0}, 0.1,{startDelay = 0.15, ease = 'circOut'})
runTimer('swappranks',1)
end

function onTimerCompleted(name)
if name == 'changestuff' then
runTimer('changestuff',3)
doTweenAlpha('dbdiefornow','dad',0,0.5,'quadOut')
elseif name == 'endvideo' then
runHaxeCode([[yoylefakes.destroy();]])
Cutscene = false
startCountdown()
return Function_Continue;
elseif name == 'swappranks' then
prankchange = getRandomInt(1,4,prankchange)
loadGraphic('frame','backgrounds/yoylefake/pranks000'..prankchange)
runTimer('reswap',getRandomInt(2,4))
startTween('prankswap3','frame.colorTransform', {redOffset = 0, greenOffset = 0, blueOffset = 0}, 0.75,{ease = 'quadOut'})
startTween('prankswap4','frame.scale', {y = 1}, 0.1,{startDelay = 0.15, ease = 'circOut'})
elseif name == 'reswap' then
Prankchange()
elseif name == 'flicker1' then
setProperty('frame.color',getColorFromHex('999999'))
runTimer('flicker2',getRandomInt(0.05,0.12))
elseif name == 'flicker2' then
setProperty('frame.color',getColorFromHex('FFFFFF'))
runTimer('flicker1',getRandomInt(4.4,4.9))
end
end
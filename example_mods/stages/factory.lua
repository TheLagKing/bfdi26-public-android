local sprite = 0

function onCreate() 
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeAnimatedLuaSprite('factory', 'backgrounds/bossy/factory',-500,-182.5)
addAnimationByPrefix('factory', 'factory', 'gb bg instance 1',24,true)
scaleObject('factory',1.25,1.25)
addLuaSprite('factory', false)

makeLuaSprite('subtract','backgrounds/bossy/SUBTRACTalpha16bgoverlay',-300,0)
setBlendMode('subtract','subtract')
setProperty('subtract.alpha',0.16)
addLuaSprite('subtract',false)

makeAnimatedLuaSprite('crew', 'backgrounds/bossy/bossybgguys',-875,277.5)
addAnimationByPrefix('crew', 'wpencil', 'bgguys1',24,true)
scaleObject('crew',0.95,0.95)
addLuaSprite('crew', false)

makeLuaSprite('march','backgrounds/bossy/helmetside1',1750,920)
setScrollFactor('march',1.25,1.25)
scaleObject('march',0.8,0.8)
addLuaSprite('march',true)

makeLuaSprite('light','backgrounds/bossy/MULTIPLYY',0,100)
addLuaSprite('light',true)
setBlendMode('light','multiply')
scaleObject('light',2,2)
screenCenter('light','x')

makeAnimatedLuaSprite('fire','backgrounds/bossy/boomboom',-335,275)
addAnimationByPrefix('fire','boom','kablooey0',24,false)
setProperty('fire.visible',false)
addLuaSprite('fire',true)
if not hideCards then
makeLuaSprite('g', 'rendersnlogos/gbrender',-500,120)
setProperty('g.alpha',1)
setObjectCamera('g','camHUD')
scaleObject('g',0.65,0.65)
addLuaSprite('g',true)

makeLuaSprite('logos', 'rendersnlogos/bossytitle',0,0)
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
screenCenter('logos','xy')
addLuaSprite('logos',true)
end
end

function onEvent(tag,v1)
if tag == 'Trigger' and v1 == 'boom' then
debugPrint('well hi explode')
setProperty('fire.visible',true)
playAnim('fire','boom')
elseif tag == 'Trigger' and v1 == 'renderout' then
spawnguy()
elseif tag == 'Trigger' and v1 == 'tbwalk' then
setProperty('gfGroup.x',getProperty('gfGroup.x')-500)
doTweenX('gfgroupmove','gfGroup',getProperty('gfGroup.x')+500,3)
addAnimationByPrefix('crew', 'wopencil', 'bgguys2',24,true)
end
end

function spawnguy()
sprite = getRandomInt(1,2)
setProperty('march.x',1750)
doTweenX('marching','march',-900,getRandomInt(15,25))

loadGraphic('march', 'backgrounds/bossy/helmetside'..sprite..'')
end

function onTweenCompleted(tag)
if tag == 'marching' then
runTimer('marchstartagain',getRandomInt(5,12.5))
end
end

function onTimerCompleted(name)
if name == 'marchstartagain' then
spawnguy()
end
end

function onBeatHit()
if curBeat % 1 == 0 then
setProperty('march.y',945)
cancelTween('marchgoback')
doTweenY('marchgoback','march',920,getRandomFloat(0.25,1),'circOut')
end
end
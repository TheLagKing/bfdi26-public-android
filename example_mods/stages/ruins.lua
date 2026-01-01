local bop = false
local gelebop = true --bro thinks hes the main character cause i gotta add a second bop JUST FOR HIM

characterArray = {'balloony','blocky','flower','firey','gel','leafy','lollipop','loser','ruble','spongy','td','wt'}

function onCreate() 
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeLuaSprite('beam', 'backgrounds/hey-two/four/skyboxbfbps',-100,-550)
setScrollFactor('beam',0.1,0.1)
addLuaSprite('beam',false)

makeLuaSprite('bgg', 'backgrounds/hey-two/four/backgroundgroundbfbps',-2500,-300)
setScrollFactor('bgg',0.25,0.25)
scaleObject('bgg',1.35,1.35)
addLuaSprite('bgg',false)

makeLuaSprite('ground', 'backgrounds/hey-two/four/groundbfbps',575,350)
addLuaSprite('ground',false)
if not hideCards then
makeAnimatedLuaSprite('logos', 'rendersnlogos/hey four titlecard',0,0)
scaleObject('logos',0.65,0.65)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','other')
addLuaSprite('logos',true)
end

-- characters oh boy what the hell
makeAnimatedLuaSprite('balloony','backgrounds/hey-two/four/bgset/bgsetballoony',1225,575)
addAnimationByPrefix('balloony','shock',' bgsetballoonyshock instance 1',24,false)
addAnimationByPrefix('balloony','bop',' bgsetballoony instance 1',24,false)
addLuaSprite('balloony',false)

makeAnimatedLuaSprite('gel','backgrounds/hey-two/four/bgset/bgsetgel',1615,725)
addAnimationByPrefix('gel','fall','bgsetgelfall instance 1',24,false)
addAnimationByPrefix('gel','bop','bgsetgel instance 1',24,false)
addAnimationByPrefix('gel','bop2','bgsetgel1 instance 1',24,false)
addLuaSprite('gel',false)

makeAnimatedLuaSprite('wt','backgrounds/hey-two/four/bgset/bgsetwoodytaco',1900,665)
addAnimationByPrefix('wt','wave','bgsetwoodytacowave instance 1',24,false)
addAnimationByPrefix('wt','shock','bgsetwoodytacoshock instance 1',24,false)
addAnimationByPrefix('wt','bop','bgsetwoodytaco instance 1',24,false)
addLuaSprite('wt',false)

makeAnimatedLuaSprite('td','backgrounds/hey-two/four/bgset/bgsettd',2525,775) --2225
addAnimationByPrefix('td','bop','bgsettd instance 1',24,false)
addAnimationByPrefix('td','run','bgsettdrun instance 1',24,false)
addLuaSprite('td',true)
setProperty('td.visible',false)

makeAnimatedLuaSprite('spongy','backgrounds/hey-two/four/bgset/bgsetspongy',2875,650) --2375
addAnimationByPrefix('spongy','bop','bgsetspongy instance 1',24,false)
addAnimationByPrefix('spongy','walk','bgsetspongywalk instance 1',24,false)
addLuaSprite('spongy',true)

makeAnimatedLuaSprite('leafy','backgrounds/hey-two/four/bgset/bgsetleafy',2800,625) --2500
addAnimationByPrefix('leafy','bop','bgsetleafy instance 1',24,false)
addAnimationByPrefix('leafy','walk','bgsetleafywalk instance 1',24,true)
addLuaSprite('leafy',false)

makeAnimatedLuaSprite('blocky','backgrounds/hey-two/four/bgset/bgsetblocky',700,760) --1150
addAnimationByPrefix('blocky','bop','bgsetblocky instance 1',24,false)
addAnimationByPrefix('blocky','walk','bgsetblockywalk instance 1',24,true)
addLuaSprite('blocky',false)

makeAnimatedLuaSprite('loser','backgrounds/hey-two/four/bgset/bgsetloser',1310,835)
addAnimationByPrefix('loser','bop','bgsetloser instance 1',24,false)
addLuaSprite('loser',true)

makeAnimatedLuaSprite('firey','backgrounds/hey-two/four/bgset/bgsetfirey',830,895) --1375
addAnimationByPrefix('firey','bop','bgsetfirey instance 1',24,false)
addAnimationByPrefix('firey','walk','bgsetfireywalk instance 1',24,true)
setScrollFactor('firey',1.1,1.1)
addLuaSprite('firey',true)

makeAnimatedLuaSprite('ruble','backgrounds/hey-two/four/bgset/bgsetruble',1675,895)
addAnimationByPrefix('ruble','bop','bgsetbubbleruby instance 1',24,false)
setScrollFactor('ruble',1.1,1.1)
addLuaSprite('ruble',true)

makeAnimatedLuaSprite('flower','backgrounds/hey-two/four/bgset/bgsetflower',2600,755)
addAnimationByPrefix('flower','bop','bgsetflower instance 1',24,false)
addAnimationByPrefix('flower','appear','bgsetflowerappear instance 1',24,false)
setScrollFactor('flower',1.1,1.1)
addLuaSprite('flower',true)
setProperty('flower.visible',false)

makeAnimatedLuaSprite('lollipop','backgrounds/hey-two/four/bgset/bgsetlollipop',2600,1115) --2450 765
addAnimationByPrefix('lollipop','walk','bgsetlollipopwalk instance 1',24,true)
addAnimationByPrefix('lollipop','bop','bgsetlollipop instance 1',24,false)
setScrollFactor('lollipop',1.1,1.1)
addLuaSprite('lollipop',true)
-- end me


makeLuaSprite('black', '', 0, 0)
setScrollFactor('black', 0, 0)
makeGraphic('black',1280,720,'00FF00')
setBlendMode('black','multiply')
setProperty('black.alpha',0)
setObjectCamera('black','other')
scaleObject('black',1.5,1.5)
addLuaSprite('black',true)
screenCenter('black', 'xy')
end

function onCreatePost()
setProperty('gf.visible',false)
setProperty('iconP1.flipX',true)
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'renderin' then
setProperty('logos.alpha',1)
addAnimationByPrefix('logos', 'title', 'hey four title instance 1',24,false)
elseif name == 'Trigger' and v1 == 'renderout' then
startTween('logo','logos',{alpha = 0}, 0.5,{startDelay = 3, ease = 'quadOut'})
table.remove(characterArray, 2)
objectPlayAnimation('blocky','walk',true)
elseif name == 'Trigger' and v1 == 'blocky' then
objectPlayAnimation('blocky','walk',true)
startTween('blockygoin','blocky',{x = 1150}, 4.1,{startDelay = 1.25})
runTimer('walkb',5.3)
elseif name == 'Trigger' and v1 == 'firey' then
table.remove(characterArray, 3)
playAnim('firey','walk',true)
doTweenX('fireygoin','firey',1375,3)
runTimer('walkf',3)
elseif name == 'Trigger' and v1 == 'x' then
setProperty('gfGroup.y',-500)
setProperty('gf.visible',true)
doTweenY('xcomein','gfGroup',195,1.65,'quadInOut')
runTimer('fall',1.21)
elseif name == 'Trigger' and v1 == 'lollipoo' then
table.remove(characterArray, 3)
playAnim('lollipop','walk',true)
doTweenX('poogoinx','lollipop',2400,3,'circOut')
doTweenY('poogoiny','lollipop',765,3,'circOut')
runTimer('walkl',2.5)
elseif name == 'Trigger' and v1 == 'flower' then
table.remove(characterArray, 1)
setProperty('flower.x',getProperty('flower.x')-90)
setProperty('flower.y',getProperty('flower.y')+30)
playAnim('flower','appear',true)
setProperty('flower.visible',true)
runTimer('appearf',1)
elseif name == 'Trigger' and v1 == 'leafy' then
table.remove(characterArray, 1)
table.remove(characterArray, 8)
doTweenX('leafygoin','leafy',2440,1.95)
playAnim('leafy','walk',true)
playAnim('wt','wave',true)
runTimer('walkll',2.25)
setProperty('leafy.y',627.5)
elseif name == 'Trigger' and v1 == 'td' then
table.remove(characterArray, 4)
playAnim('td','run',true)
doTweenX('tdrun','td',2195,1.25)
runTimer('tdran',1.95)
setProperty('td.visible',true)
setProperty('td.y',755.5)
elseif name == 'Trigger' and v1 == 'spongy' then
table.remove(characterArray, 3)
playAnim('spongy','walk',true)
doTweenX('spongygoin','spongy',2375,3)
runTimer('walks',3.5)
elseif name == 'Trigger' and v1 == 'ending' then
bop = false
setProperty('camZooming',false)
startTween('camgameout','camGame',{zoom = 0.1}, 2,{startDelay = 0.25,ease = 'cubeInOut'})
doTweenAlpha('blackout','black',1,1)
doTweenColor('blackcolor','black','000000',1)
elseif name == 'Trigger' and v1 == 'bop' then
bop = true
setProperty('isCameraOnForcedPos', true)
elseif name == 'Trigger' and v1 == 'unbop' then
bop = false
setProperty('isCameraOnForcedPos', false)
setProperty('camGame.x',0)
elseif name == 'Trigger' and v1 == 'bop2' then
bop = true
setProperty('isCameraOnForcedPos', true)
end
end

function onBeatHit()
if curBeat % 2 == 0 then
for i = 0, #characterArray do
objectPlayAnimation(characterArray[i],'bop')
end
elseif curBeat % 2 == 1 and gelebop == true then
objectPlayAnimation('gel','bop2')
end

if curBeat % 2 == 0 and bop == true then
cancelTween('camhudtlive')
cancelTween('camGametlive')

setProperty('camHUD.y',5)
doTweenY('camhudtlive','camHUD',0,0.75,'quadOut')
triggerEvent('Add Camera Zoom','','')

setProperty('camGame.y',5)
doTweenY('camGametlive','camGame',0,0.75,'quadOut')
end
end

function onTimerCompleted(tag)
if tag == 'walkf' then
characterArray[#characterArray+1] = 'firey'
elseif tag == 'walkl' then
characterArray[#characterArray+1] = 'lollipop'
elseif tag == 'appearf' then
characterArray[#characterArray+1] = 'flower'
objectPlayAnimation('flower','bop')
setProperty('flower.x',2600)
setProperty('flower.y',775)
elseif tag == 'walkb' then
playAnim('blocky','bop')
characterArray[#characterArray+1] = 'blocky'
elseif tag == 'fall' then
table.remove(characterArray, 3)
table.remove(characterArray, 1)
table.remove(characterArray, 8)
gelebop = false
playAnim('gel','fall',true)
playAnim('balloony','shock',true)
playAnim('wt','shock',true)
setProperty('gel.x',getProperty('gel.x')-200)
setProperty('gel.y',getProperty('gel.y')-75)
runTimer('endshock',2)
elseif tag == 'endshock' then
characterArray[#characterArray+1] = 'balloony'
characterArray[#characterArray+1] = 'wt'
elseif tag == 'walkll' then
objectPlayAnimation('leafy','bop')
setProperty('leafy.x',2500)
setProperty('leafy.y',625)
characterArray[#characterArray+1] = 'leafy'
characterArray[#characterArray+1] = 'wt'
elseif tag == 'tdran' then
objectPlayAnimation('td','bop')
characterArray[#characterArray+1] = 'td'
setProperty('td.x',2225)
setProperty('td.y',775)
elseif tag == 'walks' then
objectPlayAnimation('spongy','bop')
setProperty('spongy.y',715)
characterArray[#characterArray+1] = 'spongy'
end
end
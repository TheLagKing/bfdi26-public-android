camstop = nil

function onSongStart()
startTween('blackout2','black',{alpha = 0}, 10,{startDelay = 2.5,ease = 'cubeInOut'})
end

BteamArray = {'b','n','l','k','bb','box'}
PteamArray = {'f','c','ca','t','bo','g'}

function onCreate() 
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeLuaSprite('sky','backgrounds/invitational/Skyy',-580,-200)
setProperty('sky.alpha',0.75)
setScrollFactor('sky',0.1,0.1)
addLuaSprite('sky',false)

makeLuaSprite('sun','backgrounds/invitational/Sunny',1150,800)
setProperty('sun.alpha',1)
setScrollFactor('sun',0.15,0.15)
addLuaSprite('sun',false)

makeLuaSprite('bgcolour', '',3000,1975)
makeGraphic('bgcolour',1,1,'8BE86F')
scaleObject('bgcolour',3900,1500)
setProperty('bgcolour.alpha',1)
setProperty('bgcolour.visible',true)
addLuaSprite('bgcolour',false)

makeLuaSprite('mount','backgrounds/invitational/Mountainy',1560,435)
setProperty('mount.alpha',1)
setScrollFactor('mount',0.3,0.3)
addLuaSprite('mount',false)

makeLuaSprite('island','backgrounds/invitational/Backgroundy',550,675)
setProperty('island.alpha',1)
setScrollFactor('island',0.4,0.4)
addLuaSprite('island',false)

makeLuaSprite('island3','backgrounds/invitational/Foregroundy 1',2000,915)
setProperty('island3.alpha',1)
setScrollFactor('island3',0.75,0.75)
addLuaSprite('island3',false)

makeLuaSprite('island2','backgrounds/invitational/Foregroundy 2',4500,980)
setProperty('island2.alpha',1)
setScrollFactor('island2',0.75,0.75)
addLuaSprite('island2',false)

-- teams
-- blue
makeAnimatedLuaSprite('b','backgrounds/invitational/teams/BTeam Balloon',2875,1575)
addAnimationByPrefix('b','bop','Balloon Idle instance 1',24,true)
setScrollFactor('b',0.85,0.85)
addLuaSprite('b')

makeAnimatedLuaSprite('l','backgrounds/invitational/teams/BTeam Lifering',3100,1525)
addAnimationByPrefix('l','bop','Lifering Idle instance 1',24,true)
setScrollFactor('l',0.85,0.85)
addLuaSprite('l')

makeAnimatedLuaSprite('k','backgrounds/invitational/teams/BTeam Kettle',3360,1490)
addAnimationByPrefix('k','bop','Tea Kettle Idle instance 1',24,true)
setScrollFactor('k',0.85,0.85)
addLuaSprite('k')

makeLuaSprite('box','backgrounds/invitational/teams/BTeam Box',3325,1750)
setScrollFactor('box',0.85,0.85)
addLuaSprite('box')

makeAnimatedLuaSprite('bb','backgrounds/invitational/teams/BTeam Blueberry',3510,1725)
addAnimationByPrefix('bb','bop','Blueberry Idle instance 1',24,true)
setScrollFactor('bb',0.85,0.85)
addLuaSprite('bb')

makeAnimatedLuaSprite('n','backgrounds/invitational/teams/BTeam Nickel',3025,1675)
addAnimationByPrefix('n','bop','Nickel Idle instance 1',24,true)
setScrollFactor('n',0.85,0.85)
addLuaSprite('n')
--
-- pink
makeAnimatedLuaSprite('c','backgrounds/invitational/teams/PTeam Clover',4825,1450)
addAnimationByPrefix('c','bop','Clover Unpaint instance 1',24,true)
setScrollFactor('c',0.85,0.85)
addLuaSprite('c')

makeAnimatedLuaSprite('t','backgrounds/invitational/teams/PTeam Tube',5235,1450)
addAnimationByPrefix('t','bop','Test Tube Idle instance 1',24,true)
setScrollFactor('t',0.85,0.85)
addLuaSprite('t')

makeAnimatedLuaSprite('ca','backgrounds/invitational/teams/PTeam Cabby',5375,1500)
addAnimationByPrefix('ca','bop','Cabbiness instance 1',24,true)
setScrollFactor('ca',0.85,0.85)
addLuaSprite('ca')

makeAnimatedLuaSprite('f','backgrounds/invitational/teams/PTeam Fan',5000,1525)
addAnimationByPrefix('f','bop','Fan Idle instance 1',24,true)
setScrollFactor('f',0.85,0.85)
addLuaSprite('f')

makeAnimatedLuaSprite('bo','backgrounds/invitational/teams/PTeam Bow',4700,1650)
addAnimationByPrefix('bo','bop','Bow Idle instance 1',24,true)
setScrollFactor('bo',0.85,0.85)
addLuaSprite('bo')

makeAnimatedLuaSprite('g','backgrounds/invitational/teams/PTeam Goo',5300,1725)
addAnimationByPrefix('g','bop','Goo Paint instance 1',24,true)
setScrollFactor('g',0.85,0.85)
addLuaSprite('g')
--
for i = 1,#PteamArray do
setProperty(PteamArray[i]..'.alpha',0.001)
setProperty(BteamArray[i]..'.alpha',0.001)
end
--

makeLuaSprite('bgcolour2', '',0,0)
setScrollFactor('bgcolour2',0,0)
screenCenter('bgcolour2','xy')
setProperty('bgcolour2.x',getProperty('bgcolour2.x')-1600)
setProperty('bgcolour2.y',getProperty('bgcolour2.y')-700)
makeGraphic('bgcolour2',1,1,'FFFFFF')
scaleObject('bgcolour2',3250,1450)
setProperty('bgcolour2.alpha',1)
setProperty('bgcolour2.visible',false)
addLuaSprite('bgcolour2',false)

makeLuaSprite('blue', '',3200,2391)
makeGraphic('blue',3280,30,'f3858b')
setProperty('blue.alpha',0)
addLuaSprite('blue',false)


if not hideCards then
makeLuaSprite('logos', 'rendersnlogos/invitationaltitlecard',0,0)
setProperty('logos.alpha',0)
scaleObject('logos',0.5,0.5)
setObjectCamera('logos','camHUD')
screenCenter('logos','xy')
addLuaSprite('logos',true)
end

makeLuaSprite('transition', '',-1280,0);
makeGraphic('transition',1280,720,'000000')
addLuaSprite('transition',false);
setObjectCamera('transition', 'camHUD')

makeLuaSprite('black', '', 0, 0)
setScrollFactor('black', 0, 0)
makeGraphic('black',1280,720,'000000')
setProperty('black.alpha',1)
setObjectCamera('black','other')
scaleObject('black',1.5,1.5)
addLuaSprite('black',true)
screenCenter('black', 'xy')
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'renderin' then
doTweenAlpha('logoshit','logos',1,2,'quadOut')
doTweenX('scalelogox','logos.scale',0.75,10,'sineOut')
doTweenY('scalelogoy','logos.scale',0.75,10,'sineOut')
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenAlpha('logoshit2','logos',0,3,'quadOut')
elseif name == 'Trigger' and v1 == 'blueraid' then
if not hideHud then
setProperty('healthBar.alpha',0)
setProperty('iconP1.alpha',0)
setProperty('iconP2.alpha',0)
end
setProperty('blue.visible',true)
setProperty('bgcolour2.visible',true)
doTweenColor('colourblue','blue','00bfff',3)
doTweenColor('colourblue2','bgcolour2','37c9fa',3)
elseif name == 'Trigger' and v1 == 'unblueraid' then
if not hideHud then
setProperty('healthBar.alpha',1)
setProperty('iconP1.alpha',1)
setProperty('iconP2.alpha',1)
end
setProperty('blue.visible',false)
setProperty('bgcolour2.visible',false)
elseif name == 'Trigger' and v1 == 'move' then
camstop = true
setProperty('isCameraOnForcedPos',true)
doTweenZoom('camgamezoom','camGame',1.25,1,'circOut')
doTweenX('camX3', 'camFollow',getProperty('boyfriend.x')+300,0.2,'circOut')
doTweenY('camY4', 'camFollow',getProperty('boyfriend.y')+175,0.25,'circOut')
for i = 0,3 do
noteTweenAlpha('strumdieokay'..i..'',i,0,1,'quadOut')
end
elseif name == 'Trigger' and v1 == 'unmove' then
camstop = false
setProperty('isCameraOnForcedPos',false)
setProperty('camZooming',true)
doTweenZoom('camgamezoom2','camGame',getProperty('defaultCamZoom'),1,'circOut')
for i = 0,3 do
noteTweenAlpha('strumdieokay2'..i..'',i,1,1,'quadOut')
end
elseif name == 'Transition' then
setProperty('transition.x',-1280)
doTweenX('part1', 'transition',0,v1, 'linear')
elseif name == 'Trigger' and v1 == 'end' then
setProperty('black.color',getColorFromHex('0000FF'))
setBlendMode('black','multiply')
setProperty('camZooming',false)
startTween('camgameout','camGame',{zoom = 0.1}, 2,{startDelay = 0.25,ease = 'cubeInOut'})
doTweenAlpha('blackout','black',1,1)
doTweenColor('blackcolor','black','000000',1)
elseif name == 'Trigger' and v1 == 'sunrise' then
doTweenY('sunrise1','sun',-300,9.8,'expoInOut')
elseif name == 'Trigger' and v1 == 'sunriseend' then
doTweenAlpha('sunrise2','sky',1,0.5,'quadOut')
elseif name == 'Trigger' and v1 == 'p' then
for i = 1,#PteamArray do
setProperty(PteamArray[i]..'.alpha',1)
end
elseif name == 'Trigger' and v1 == 'b' then
for i = 1,#BteamArray do
setProperty(BteamArray[i]..'.alpha',1)
end

end
end

function onTweenCompleted(tag)
if tag == 'part1' then
doTweenX('transitiondie','transition',1280,0.175)
elseif tag == 'colourred' then
doTweenColor('colourpurple','blue','dfdbff',3)
	doTweenColor('colourpurple2','bgcolour2','dfdbff',3)
elseif tag == 'colourpurple' then
doTweenColor('colourblue','blue','00bfff',3)
	doTweenColor('colourblue2','bgcolour2','37c9fa',3)
elseif tag == 'colourblue' then
doTweenColor('colourred','blue','861E85',3)
doTweenColor('colourred2','bgcolour2','F4BEFC',3)
end
end

function onUpdatePost()
if camstop == true then
setProperty('camZooming',false)
end
end
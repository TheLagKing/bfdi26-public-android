local cutscene = true
local char = 1
local canmove = false

function onStartCountdown()    
if cutscene == true and difficultyName == 'Normal' then
return Function_Stop;
end
end

function onSongStart()
doTweenAlpha('timetxtdie','timeTxt',0.5,1)
startTween('blackgo','black',{alpha = 0}, 10,{startDelay = 1.65,ease = 'linear'})
setProperty('isCameraOnForcedPos', true)
setProperty('camGame.zoom',6)
setProperty('camFollow.y',-125)
setProperty('camFollow.x',850)
setProperty('camHUD.alpha',0)

for p= 4,7 do
noteTweenX('movePlayer'..p, p,440 + (110 *(p - 4)), 3.25,'cubeInOut')
end
end

function onCreate() 
setProperty('camGame.bgColor',getColorFromHex('b9f9ff'))

-- select screen
makeLuaSprite('black', '', 0, 0)
setScrollFactor('black', 0, 0)
makeGraphic('black',1,1,'000000')
setObjectCamera('black','other')
addLuaSprite('black',false)
scaleObject('black',1285,720)
screenCenter('black', 'xy')

if difficultyName == 'Normal' then
makeLuaSprite('text','backgrounds/aewbc/select/creppy textoid',700,-525) --25
setObjectCamera('text','other')
addLuaSprite('text')

makeLuaSprite('14','backgrounds/aewbc/select/fourteen render',-25,265)
setObjectCamera('14','other')
scaleObject('14',0.3,0.3)
addLuaSprite('14')

makeLuaSprite('mike','backgrounds/aewbc/select/mike H render',0,250)
setObjectCamera('mike','other')
scaleObject('mike',0.3,0.3)
screenCenter('mike','x')
setProperty('mike.x',getProperty('mike.x')+35)
addLuaSprite('mike')

makeLuaSprite('countless','backgrounds/aewbc/select/countless render',790,260)
setObjectCamera('countless','other')
scaleObject('countless',0.3,0.3)
addLuaSprite('countless')

makeLuaSprite('arrow','backgrounds/aewbc/select/creppy arrowoid',635,-550) --150
setObjectCamera('arrow','other')
addLuaSprite('arrow')
end
--

makeLuaSprite('city','backgrounds/aewbc/lovely skyline',-325,-165)
setScrollFactor('city',0.925,0.925)
addLuaSprite('city')

makeLuaSprite('house','backgrounds/aewbc/lovely home',-320,-145)
setScrollFactor('house',0.975,0.975)
setProperty('house.alpha',1)
addLuaSprite('house')

makeLuaSprite('wm','backgrounds/aewbc/washing machine n microwave',814,211)
setScrollFactor('wm',0.9799,0.9799)
addLuaSprite('wm')

makeLuaSprite('bike','backgrounds/aewbc/mike_s bike',707.5,267.5)
setScrollFactor('bike',0.98,0.98)
addLuaSprite('bike')

makeLuaSprite('cans','backgrounds/aewbc/buckets n soda can',377.5,382.5)
setScrollFactor('cans',0.995,0.995)
addLuaSprite('cans')

makeLuaSprite('chairs','backgrounds/aewbc/chairs n junk',22.5,167.5)
addLuaSprite('chairs')

makeLuaSprite('bushes','backgrounds/aewbc/foreground shrubbery',-325,475)
setScrollFactor('bushes',1.1,1.1)
addLuaSprite('bushes',true)

if not hideCards then
makeLuaSprite('logos','rendersnlogos/aewbcttitlecard',-500,0)
setObjectCamera('logos','camHUD')
scaleObject('logos',0.75,0.75)
addLuaSprite('logos',true)

if downscroll then
setProperty('logos.y',400)
end
end

end

function onCreatePost()
setProperty('textmiss.alpha',1)
setProperty('textacc.alpha',1)

if difficultyName == 'Normal' then
for _, stuff in ipairs({'mike','14','countless'}) do setProperty(stuff..'.alpha',0) startTween('tweenshit'..stuff,stuff,{alpha = 1}, 2.5,{startDelay = 1.5,ease = 'cubeOut'}) end
startTween('tweenshit2','text',{y = 25}, 1.25,{startDelay = 3,ease = 'cubeOut'})
startTween('tweenshit3','arrow',{y = 150}, 1.35,{startDelay = 4.5,ease = 'cubeOut'})
runTimer('start',5.5)
else
setProperty('iconP1.flipX',true)
end
end

function onUpdatePost(elapsed)
if difficultyName == 'Normal' then

if canmove == true then
if keyboardJustPressed('LEFT') then
playSound('scrollup1',1)
char = char-1
elseif keyboardJustPressed('RIGHT') then
playSound('scrollup1',1)
char = char+1
elseif char >2 then
char = 0
elseif char <0 then
char = 2
elseif char == 0 and getProperty('arrow.x') ~= 250 then
doTweenX('movex0','arrow',250,1.25,'circOut')
cancelTween('movex1')
cancelTween('movex2')
elseif char == 1 and getProperty('arrow.x') ~= 635 then
doTweenX('movex1','arrow',635,1.25,'circOut')
cancelTween('movex0')
cancelTween('movex2')
elseif char == 2 and getProperty('arrow.x') ~= 985 then
doTweenX('movex2','arrow',985,1.25,'circOut')
cancelTween('movex1')
cancelTween('movex0')
end





if keyboardJustPressed('ENTER') then
setProperty('skipCountdown',true)
playSound('enterimpact',1)
stopSound('AEWBCTheme')
cutscene = false
for _, stuff2 in ipairs({'arrow','text'}) do startTween('tweenshitend'..stuff2,stuff2,{y = -500}, 1.5,{startDelay = 0.25,ease = 'cubeIn'}) end
runTimer('die',4.5)

if char == 0 then
startTween('tweenshit1','14',{alpha = 0}, 1.25,{startDelay = 2,ease = 'cubeOut'})
startTween('tweenshitend2','mike',{x = 2900}, 1.75,{startDelay = 0.35,ease = 'cubeIn'})
startTween('tweenshitend3','countless',{x = 2900}, 1.95,{startDelay = 0.45,ease = 'cubeIn'})
elseif char == 1 then
startTween('tweenshitend2','14',{x = -1000}, 1.75,{startDelay = 0.35,ease = 'cubeIn'})
startTween('tweenshit4','mike',{alpha = 0}, 1.25,{startDelay = 2,ease = 'cubeOut'})
startTween('tweenshitend3','countless',{x = 2900}, 1.95,{startDelay = 0.45,ease = 'cubeIn'})
elseif char == 2 then
startTween('tweenshitend2','14',{x = -1000}, 1.75,{startDelay = 0.35,ease = 'cubeIn'})
startTween('tweenshitend22','mike',{x = -1000}, 1.75,{startDelay = 0.35,ease = 'cubeIn'})
startTween('tweenshit48','countless',{alpha = 0}, 1.25,{startDelay = 2,ease = 'cubeOut'})
end

canmove = false
return Function_Continue;
end
end
end
end

function onTimerCompleted(tag)
if tag == 'die' and char == 1 then
startCountdown()
elseif tag == 'die' and char == 2 then
loadSong('aewbc',0)
elseif tag == 'die' and char == 0 then
loadSong('aewbc',2)
elseif tag == 'start' then
canmove = true
playSound('AEWBC Selection Theme',1,'AEWBCTheme')
end
end

function onEvent(n,v1)
if n == 'Trigger' then
if v1 == 'renderin' then
doTweenAlpha('coolhudcomeback','camHUD',1,1.25)
startTween('camgamecool','camGame',{zoom = getProperty('defaultCamZoom')}, 3.25,{startDelay = 0.5,ease = 'quartInOut'})
startTween('coolzoomback','camFollow',{x = 625, y = 300}, 2.35,{startDelay = 0.25,ease = 'quartInOut'})
doTweenX('lgooshsit','logos',5,1.25,'circOut')
elseif v1 == 'out' then
doTweenX('lgooshsit2','logos',-500,1.25,'quintIn')
elseif v1 == 'endblack' then
addLuaSprite('black',true)
makeGraphic('black',1,1,'FFFFFF')
startTween('blackgo2','black',{alpha = 1}, 1.25,{startDelay = 0.5,ease = 'quadOut'})
end
end
end
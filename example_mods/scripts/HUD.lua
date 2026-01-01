local acc = 0
local unlocked = false
local fourbythree = false
local NAME = ''
local font = 'Shag-Lounge.OTF'
local logo = ''

local hudArray = {
{Song = 'yoylefake', font = 'Shag-Lounge.OTF', NAME = 'YOYLEFAKE', logo = 'logojnj', fbt = false},
{Song = 'eternal', font = 'flareserif-821-bt-bold.TTF', NAME = "FOUR'S ETERNAL ALGEBRA CLASS.", logo = 'logojnjm', fbt = false},
{Song = 'funny-fellow', font = 'Shag-Lounge.OTF', NAME = '"Wow what a cool window!!!"', logo = 'logogreeny', fbt = false},
{Song = 'funny-fellow-spooky', font = 'Shag-Lounge.OTF', NAME = 'Wholesome ! Song!', logo = 'logogreeny', fbt = false},
{Song = 'wrong-finger', font = 'Shag-Lounge.OTF', NAME = "BFDI 1a: Take the Plunge", logo = 'logojnj', fbt = false},
{Song = 'vocal-chords', font = 'flareserif-821-bt-bold.TTF', NAME = "BFB 1: Getting Teardrop to Talk", logo = 'logojnjm', fbt = false},
{Song = 'oneshot', font = 'one.TTF', NAME = 'To live without you is death to me.', logo = 'logocheesy', fbt = false},
{Song = 'oneshot-pico', font = 'one.TTF', NAME = 'Take me back.', logo = 'logocheesy', fbt = false},
{Song = 'time', font = 'Consolas.TTF', NAME = '"IT\'S TIME FOR THE [12:00] - This Friday Night!!"', logo = 'logoderp', fbt = false},
{Song = 'web-crasher', font = 'impact.TTF', NAME = '"Pride preide pride rpurde pride! flag flag pride flaah g id there a limit to how long it can be"', logo = 'logooomf', fbt = true},
{Song = 'web-crasher-gf', font = 'impact.TTF', NAME = '"Hourglass horuglas s thoug allas hour hour glabs! horglaes there a limit to how long it can be"', logo = 'logooomf', fbt = true},
{Song = 'well-rounded', font = 'Comic Sans MS.TTF', NAME = 'BFC 15: Circle', logo = 'logocheesy', fbt = false},
{Song = 'invitational', font = 'MarioLuigi2.TTF', NAME = '"I would write a funny application window message here, but I\'m a fat slob, so I didn\'t!"', logo = 'logoepic', fbt = false},
{Song = 'invitational-dearest', font = 'MarioLuigi2.TTF', NAME = 'A real DADbattle!', logo = 'logoepic', fbt = false},
{Song = 'himsheys', font = 'Shag-Lounge.OTF', NAME = 'January 2009 - Firey\'s Candy Bar Adventure', logo = '', fbt = true},
{Song = 'himsheys-tird', font = 'Shag-Lounge.OTF', NAME = 'January 2009 - Income Tax Return Document\'s Candy Bar Adventure', logo = '', fbt = true},
{Song = 'hey-two', font = 'TPOT.TTF', NAME = '"Hey Two!"', logo = 'logojnjm', fbt = false},
{Song = 'hey-two-gf', font = 'flareserif-821-bt-bold.TTF', NAME = '"Hey Four!"', logo = 'logojnjm', fbt = false},
{Song = 'new-friendly', font = 'Shag-Lounge.OTF', NAME = 'Kevin MacLeod!', logo = 'logoAnko', fbt = false},
{Song = 'syskill', font = 'Shag-Lounge.OTF', NAME = '"Speaker is out because she is A POO!"', logo = 'logothanos', fbt = false},
{Song = 'syskill-pico', font = 'Shag-Lounge.OTF', NAME = '"Sour Apple is out because he is A POO also it\'s night now!"', logo = 'logothanos', fbt = false},
{Song = 'blue-golfball', font = 'Shag-Lounge.OTF', NAME = "John BFDI26", logo = '', fbt = false},
{Song = 'blue-golfball-bf', font = 'Shag-Lounge.OTF', NAME = "John BFDI 26 - Now she's serious", logo = '', fbt = false},
{Song = 'evil-song', font = 'Shag-Lounge.OTF', NAME = '"MY SONG IS THE BEST AND MOST PERFECT AS A VILLAIN THEME SONG!"', logo = 'logosacri', fbt = false},
{Song = 'evil-song-pico', font = 'Shag-Lounge.OTF', NAME = 'They\'re gay.', logo = 'logosacri', fbt = false},
{Song = 'dotted-line', font = 'TPOT.TTF', NAME = 'Don\'t forget to pay me back!', logo = 'logojnjm', fbt = false},
{Song = 'kms', font = 'Shag-Lounge.OTF', NAME = 'Oh my god...', logo = 'logomilk', fbt = false},
{Song = 'whos-there', font = 'flareserif-821-bt-bold.TTF', NAME = 'In The Evil Forest...', logo = 'logojnj', fbt = false},
{Song = 'hard-bargain', font = 'TPOT.TTF', NAME = "SELLING. CHILDREN.", logo = 'logojnjm', fbt = false},
{Song = 'hello-operator', font = 'Shag-Lounge.OTF', NAME = 'LOVE OF THE S*N 1A: YOU ONLY LIVE TWICE', logo = 'logoMal', fbt = false},
{Song = 'help-me', font = 'Shag-Lounge.OTF', NAME = '"Oh. Is this the planet we have to go to..?', logo = 'logochalk', fbt = false},
{Song = 'underway', font = 'BMSPA___.TTF', NAME = '"You certainly know a thing or two about punctuality!"', logo = 'logoal', fbt = false},
{Song = 'bossy', font = 'Shag-Lounge.OTF', NAME = '"Give us that Poopy Mayonnaise!"', logo = 'logojnj', fbt = false},
{Song = 'bossy-lunch', font = 'Shag-Lounge.OTF', NAME = '"GET ME DOWN FROM HERE!! You DON\'T know how to properly handle THAT!"', logo = 'logojnjm', fbt = false},
{Song = 'aldi', font = "LTAsus-Bold.TTF", NAME = 'Shop smarter!', logo = 'logoalddi', fbt = false},
}

function formatTime(millisecond)
local seconds = math.floor(millisecond / 1000)
return string.format("%01d:%02d", (seconds / 60) % 60, seconds % 60)  
end

function round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
n = math.pow(10, n or 0)
x = x * n
if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
return x / n
end

function onSongStart()
if middlescroll then
for note = 4,7 do
noteTweenAlpha('notes come to those who wait'..note..'',note,1,1.6)
end
end
end

function onCreate()
setProperty('timeTxt.visible',false)
setProperty('timeTxt.alpha',0)
setProperty('camGame.bgColor', getColorFromHex('000000'))
setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
setObjectCamera('mouse','other')
setProperty('skipCountdown',true)

makeLuaSprite('Logo','',1195,640)
addLuaSprite('Logo',true)
setProperty('Logo.alpha',0.5)
scaleObject('Logo',0.9,0.9)
setObjectCamera('Logo','other')

for i = 1,#hudArray do
if songName == hudArray[i].Song then
font = hudArray[i].font
NAME = hudArray[i].NAME
logo = hudArray[i].logo
fourbythree = hudArray[i].fbt
loadGraphic('Logo','hud/'..hudArray[i].logo..'')
if logo == '' then
removeLuaSprite('Logo')
end
end
end

if checkFileExists("BFDI26/weeks/6.json") then
unlocked = true
else
unlocked = false
end

for i = 0, 3 do
makeLuaSprite('strumbg', '',0,-200)
makeGraphic('strumbg',450,1120,'000000')
setBlendMode('strumbg','multiply')
setProperty('strumbg.alpha',strumBGAlpha)
setObjectCamera('strumbg','camHUD')
addLuaSprite('strumbg',true)
end

makeLuaSprite('bars', 'hud/bars',0,0)
setObjectCamera('bars','camHUD')
setProperty('bars.alpha',0)
addLuaSprite('bars',true)

if not hideHud then
makeLuaText('textmiss', 'Votes: 0',1000,0,0)
setProperty('textmiss.alpha',0)
setTextBorder('textmiss',1.25,'000000')
addLuaText('textmiss',true)

makeLuaText('textacc', 'Acc: ?',1000,0,0)
setProperty('textacc.alpha',0)
setTextBorder('textacc',1.25,'000000')
addLuaText('textacc',true)
end

setPropertyFromClass('lime.app.Application', 'current.window.title','BFDI 26: '..NAME..'')
end

function onCreatePost()
if opponentStrums == false then
for i = 0, 3 do
setPropertyFromGroup('opponentStrums', i, 'y', 9999)
end
end

setProperty('comboGroup.scollFactor.x',0.95)
setProperty('comboGroup.scollFactor.y',0.95)

setProperty('timeBar.visible',false)
setTextFont('botplayTxt',font)

if not hideHud then
setTextSize('scoreTxt',27.5)
setTextFont('scoreTxt',font)

setTextSize('textmiss',25)
setObjectOrder('textmiss',getObjectOrder('uiGroup')+1)
setTextFont('textmiss',font)

setTextSize('textacc',25)
setObjectOrder('textacc',getObjectOrder('uiGroup')+5)
setTextFont('textacc',font)

screenCenter('textacc','x')
screenCenter('textmiss','x')
screenCenter('scoreTxt','x')
screenCenter('botplayTxt','x')

setTextAlignment('scoreTxt','center')
setTextAlignment('textacc','left')
setTextAlignment('textmiss','left')
setProperty('textacc.alpha',getProperty('textmiss.alpha'))

setTextFont('timeTxt',font)
setProperty('timeTxt.x',-100)
setProperty('timeTxt.y',665)
setTextSize('timeTxt',25)
setObjectCamera('timeTxt','other')

if font == 'TPOT.TTF' then
setTextSize('textacc',45)
setTextSize('textmiss',45)
setTextSize('scoreTxt',47.5)
setTextSize('timeTxt',45)
setTextSize('botplayTxt',45)
setProperty('timeTxt.y',645)
elseif font == 'BMSPA___.TTF' then
setTextSize('textacc',20)
setTextSize('textmiss',20)
setTextSize('scoreTxt',22.5)
end

setProperty('textacc.x',getProperty('scoreTxt.x')+825)
setProperty('textmiss.x',getProperty('scoreTxt.x')+350)

else
setProperty('timeTxt.visible',false)
setProperty('reddot.visible',false)
setProperty('redline.visible',false)
removeLuaSprite('Logo')
end

if downscroll and not hideHud then
setProperty('botplayTxt.y',100)
setProperty('scoreTxt.y',25)
setProperty('textmiss.y',25)
elseif not downscroll and not hideHud then
setProperty('botplayTxt.y',590)
setProperty('scoreTxt.y',660)
setProperty('textmiss.y',660)
elseif hideHud and downscroll then
setProperty('botplayTxt.y',30)
elseif hideHud and not downscroll then
setProperty('botplayTxt.y',665)
end

setProperty('textacc.y',getProperty('textmiss.y'))
end

function onUpdatePost()
setProperty('strumbg.x',getProperty('playerStrums.members[1].x')-125)
--setProperty('defaultCamZoom',0.1)
if fourbythree == false then
setProperty('iconP1.x',850)
setProperty('iconP2.x',250)
else
setProperty('Logo.x',865)
setProperty('Logo.y',635)
setProperty('iconP1.x',700)
setProperty('iconP2.x',150)
end
setTextString('timeTxt', formatTime(getSongPosition() - noteOffset) .. ' / ' .. formatTime(songLength))

if (mouseClicked('left') or mouseClicked('right')) and getMouseY('other') >655 and getMouseY('other') <706 and getMouseX('other') >1215 and getMouseX('other') <1275 and not hideHud then
if logo == 'logojnj' or logo == 'logojnjm' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@BFDI');]])

elseif logo == 'logogreeny' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@GagOfGreen');]])

elseif logo == 'logoepic' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@AnimationEpic');]])

elseif logo == 'logocheesy' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@CheesyHfj');]])

elseif logo == 'logoderp' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@derpadon');]])

elseif logo == 'logothanos' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@Highvan');]])

elseif logo == 'logoAnko' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@Anko6theAnimator');]])

elseif logo == 'logosacri' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@SacriStuff');]])

elseif logo == 'logomilk' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@SteamedMilkStudio');]])

elseif logo == 'logoMal' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@malues');]])

elseif logo == 'logoal' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@Allenimations');]])

elseif logo == 'logochalk' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@chalkbunny.');]])

elseif logo == 'logoalddi' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@AldiUK');]])
end

elseif (mouseClicked('left') or mouseClicked('right')) and getMouseY('other') >650 and getMouseY('other') <697 and getMouseX('other') >869 and getMouseX('other') <917 and not hideHud then
if logo == 'logooomf' then
runHaxeCode([[FlxG.openURL('https://www.youtube.com/@Nyantakt');]])
end
end
end

function goodNoteHit()
acc = round((getProperty('ratingPercent') * 100), 2)
setTextString('textacc','Acc: '..acc..'%')
setTextString('textmiss','Votes: '..misses..'')
setPropertyFromClass('lime.app.Application', 'current.window.title','BFDI 26: '..NAME..': SCORE:'..score..' VOTES:'..misses..' ACCURACY:'..acc..'%')
end

function noteMiss()
if bfName ~= "liy" or "liy-angy" or 'applevember' then
triggerEvent('Play Animation','miss','boyfriend') 
end
setTextString('textmiss','Votes: '..misses..'')
setTextString('textacc','Acc: '..acc..'%')
acc = round((getProperty('ratingPercent') * 100), 2)
setPropertyFromClass('lime.app.Application', 'current.window.title','BFDI 26: '..NAME..': SCORE:'..score..' VOTES:'..misses..' ACCURACY:'..acc..'%')
end

function onDestroy()
setPropertyFromClass('lime.app.Application', 'current.window.title','BFDI 26')
end


hattySongArray = {'funny-fellow','vocal-chords','time','web-crasher','well-rounded','invitational','himsheys','hey-two','whos-there','evil-song','blue-golfball-bf'}

function onGameOver()
if not OneshotCheck then
for i = 1,#hattySongArray do
if songName == hattySongArray[i] then
loadSong('oneshot')
end
end
end
end
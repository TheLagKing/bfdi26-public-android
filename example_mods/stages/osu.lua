bgs = {'rockefellerstreet','butterflyexponent','angelwithashotgun'}
value = 0

function onCreate()
value = getRandomInt(1,#bgs,value)
makeLuaSprite('coolbackground','backgrounds/newfoundland/'..bgs[value]..'',0,0)
setObjectCamera('coolbackground','camHUD')
scaleObject('coolbackground',0.75,0.75)
setScrollFactor('coolbackground',0.25,0.25)
screenCenter('coolbackground','xy')
setProperty('coolbackground.alpha',0.5)
addLuaSprite('coolbackground',false)

makeLuaSprite('timeshit', '',0,710)
makeGraphic('timeshit',1,1,'393939')
scaleObject('timeshit',1280,10)
setProperty('timeshit.alpha',0)
setObjectCamera('timeshit','camOther')
screenCenter('timeshit','x')
addLuaSprite('timeshit',true)

makeLuaSprite('line1', '',-97.5,0)
makeGraphic('line1',1,1,'FFFFFF')
setProperty('line1.angle',90)
scaleObject('line1',1000,5)
setObjectCamera('line1','camHUD')
screenCenter('line1','y')
addLuaSprite('line1',false)

makeLuaSprite('line2', '',357.5,0)
makeGraphic('line2',1,1,'FFFFFF')
setProperty('line2.angle',90)
scaleObject('line2',1000,5)
setObjectCamera('line2','camHUD')
screenCenter('line2','y')
addLuaSprite('line2',false)

makeLuaText('textsong',songName,1000,0,0)
setProperty('textsong.alpha',0)
setTextSize('textsong',45)
setProperty('textsong.y',5)
setProperty('textsong.x',-745)
setTextFont('textsong','MarineRounded-Regular.OTF')
setObjectCamera('textsong','camHUD')
addLuaText('textsong',true)

makeLuaSprite('strumred', '',0,-200)
makeGraphic('strumred',1,1,'FF0000')
scaleObject('strumred',450,1120)
setBlendMode('strumred','multiply')
setProperty('strumred.alpha',0.01)
setObjectCamera('strumred','camHUD')
addLuaSprite('strumred',true)
end

function onCreatePost()
-- custom ui
setProperty('camGame.visible',false)
setObjectCamera('gfGroup','camHUD')
setObjectCamera('dadGroup','camHUD')
if not hideHud then
setProperty('showComboNum', false)
setProperty('timeshit.alpha',1)
setProperty('healthBar.leftBar.color',getColorFromHex('000000'))
setProperty('healthBar.rightBar.color',getColorFromHex('FFFFFF'))
setProperty('healthBar.angle',90)
setProperty('healthBar.x',50)
setProperty('healthBar.y',350)

setProperty('iconP1.visible',false)
setProperty('iconP2.visible',false)

makeLuaText('textcombo',getProperty('combo'),1000,0,0)
setProperty('textcombo.alpha',0)
setTextBorder('textcombo',1.25,'000000')
setTextSize('textcombo',40)
screenCenter('textcombo','xy')
setProperty('textcombo.y',405)
setTextFont('textcombo','MarineRounded-Regular.OTF')
addLuaText('textcombo',true)

setProperty('scoreTxt.y',5)
setProperty('scoreTxt.x',575)

setProperty('textacc.y',55)
setProperty('textacc.x',1182.5)
setProperty('textacc.alpha',1)

setProperty('textmiss.alpha',1)
setProperty('textmiss.y',85)
setProperty('textmiss.x',1220)
setProperty('textmiss.color',getColorFromHex('FF0000'))

setProperty('botplayTxt.y',5)
setProperty('botplayTxt.x',700)

setProperty('timeTxt.alpha',1)
setProperty('timeTxt.y',675)
setProperty('timeTxt.x',-160)
doTweenAlpha('timeTxtstuff','timeTxt',1,5)

makeLuaText('timeTxt2','bleh',1000,0,0)
setProperty('timeTxt2.y',675)
setProperty('timeTxt2.x',745)
setTextBorder('timeTxt2',0,'000000')
setProperty('timeTxt2.color',getColorFromHex('27aae1'))
setObjectCamera('timeTxt2','other')
setTextFont('timeTxt2','MarineRounded-Regular.OTF')
setTextSize('timeTxt2',25)
addLuaText('timeTxt2',true)
end


for i = 0,3 do
noteTweenX(i..'mid',i+4,screenWidth/2+(110*(i-2)),0.2)
noteTweenAlpha(i..'die',i,0,5)
end

if getProperty('strumbg.alpha') < 0.5 then
setProperty('strumbg.alpha',0.5)
end
setObjectOrder('strumbg',2)
--
end

function onSongStart()
startTween('starttextstuff', 'textsong', {x = -345,alpha = 1}, 1.5,{startDelay = 1, ease = 'circOut'})
end

function onUpdatePost()
setProperty('strumred.x',getProperty('playerStrums.members[1].x')-125)
end

function goodNoteHit(_, _, _, s)
    if s then return end
    local ratingIndex = getProperty('comboGroup.length') - (getProperty('showCombo') and 2 or 1)
    setProperty('comboGroup.members['..ratingIndex ..'].velocity.y',0)
    setProperty('comboGroup.members['..ratingIndex ..'].velocity.x',0)
    setProperty('comboGroup.members['..ratingIndex ..'].acceleration.y',0)
    setProperty('comboGroup.members['..ratingIndex ..'].acceleration.x',0)
    screenCenter('comboGroup.members['..ratingIndex ..']','xy')
    
    setTextString('textcombo',getProperty('combo'))
    setProperty('textcombo.alpha',1)
    startTween('textcombooh', 'textcombo', {alpha = 0}, 0.25,{startDelay = 0.35, ease = 'circOut'})
end

function noteMiss(_, _, _, s)
    if s then return end
    setTextString('textcombo','-1')
    setProperty('textcombo.alpha',1)
    startTween('textcombooh', 'textcombo', {alpha = 0}, 0.25,{startDelay = 0.35, ease = 'circOut'})

    setProperty('strumred.alpha',getProperty('strumbg.alpha'))
    startTween('strumshit', 'strumred', {alpha = 0}, 0.25,{startDelay = 0.35, ease = 'circOut'})
end

function onEvent(name,v1,v2)
if name == 'Trigger' and v1 == 'camtrue' then
setProperty('camZooming',true)
elseif name == 'Trigger' and v1 == 'camfalse' then
setProperty('camZooming',false)
end
end
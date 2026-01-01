mainArray = {'bgsky','bgground','mainground'}

function onCreate() 
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)
setBlendMode('strumbg','')
setProperty('camZooming',true)

makeLuaSprite('bgsky','backgrounds/hard-bargain/yellowsky',-325,-250)
setScrollFactor('bgsky',0.25,0.25)
addLuaSprite('bgsky')

makeLuaSprite('bgground','backgrounds/hard-bargain/yellowfuckpoop',-190,425)
setScrollFactor('bgground',0.75,0.75)
addLuaSprite('bgground')

makeLuaSprite('mainground','backgrounds/hard-bargain/yellowfuckground',-30,500)
addLuaSprite('mainground')

-- bg 1
makeLuaSprite('artbg','backgrounds/hard-bargain/bg1/groundoooohyeah',-350,-200)
scaleObject('artbg',0.8,0.8)
addLuaSprite('artbg',false)
setProperty('artbg.alpha',0.001)
--
-- ad
createInstance('bgw', 'flixel.addons.display.FlxBackdrop', {nil, 0x01, 0})
loadGraphic('bgw', 'backgrounds/hard-bargain/bg3/yellowfacebg')
setProperty('bgw.velocity.x', -500)
setProperty('bgw.alpha',0.001)
addLuaSprite('bgw',false)
--
-- week 2
makeAnimatedLuaSprite('week2','backgrounds/hard-bargain/bg2/halloween_bg',-50,150)
addLuaSprite('week2',false)
setProperty('week2.visible',false)
--

makeAnimatedLuaSprite('static','backgrounds/hard-bargain/static',0,0)
addAnimationByPrefix('static','stat','static instance 1',24,true)
addLuaSprite('static',false)
setObjectCamera('static','camHUD')
if not hideCards then
makeLuaSprite('y', 'rendersnlogos/yellowfacerender',1500,50)
setProperty('y.alpha',0.001)
setObjectCamera('y','camHUD')
scaleObject('y',0.5,0.5)
addLuaSprite('y',true)

makeLuaSprite('logos', 'rendersnlogos/hardbargaintitlew',0,0)
setProperty('logos.alpha',0.001)
setObjectCamera('logos','camHUD')
screenCenter('logos','xy')
addLuaSprite('logos',true)
end

makeLuaSprite('and','backgrounds/hard-bargain/andrew',0,0)
addLuaSprite('and',true)
setProperty('and.alpha',0.001)
screenCenter('and','xy')
setObjectCamera('and','camOther')

makeLuaSprite('bluechard','backgrounds/hard-bargain/bluechard',0,0)
addLuaSprite('bluechard',true)
setProperty('bluechard.alpha',0.001)
setObjectCamera('bluechard','camOther')
end

function onEvent(tag,v1)
if tag == 'Trigger' and v1 == 'week2' then
setProperty('week2.visible',true)
elseif tag == 'Trigger' and v1 == 'scribbleback' then
setProperty('week2.visible',false)
setProperty('artbg.alpha',1)
for i = 1,#mainArray do
setProperty(mainArray[i]..'.visible',false)
end
elseif tag == 'Trigger' and v1 == 'static' then
cameraFlash('camGame','ffffff',0.5)
doTweenAlpha('statics','static',0,0.5,'circOut')
elseif tag == 'Trigger' and v1 == 'statictween' then
doTweenAlpha('statics2','static',1,1.35,'quadOut')
elseif tag == 'Trigger' and v1 == 'colour' then
for i = 1,#mainArray do
setProperty(mainArray[i]..'.visible',true)
setProperty(mainArray[i]..'.color',getColorFromHex('4D2B2E'))
end
setProperty('week2.visible',false)
setProperty('bgw.visible',false)
setProperty('artbg.visible',false)
setProperty('static.visible',false)
elseif tag == 'Trigger' and v1 == 'funny' then
setProperty('boyfriendGroup.x',getProperty('boyfriendGroup.x')+200)
setProperty('boyfriendGroup.y',getProperty('boyfriendGroup.y')-50)
setProperty('bgw.alpha',1)
elseif tag == 'Trigger' and v1 == 'andrew' then
setProperty('canPause',false)
setProperty('camHUD.alpha',0)
setProperty('camGame.alpha',0)
setProperty('and.alpha',0)
doTweenScale('anddie','and',1.75,40)
doTweenX('andlastly','and',-300,50)
doTweenAlpha('andlive','and',1,10)
elseif tag == 'Trigger' and v1 == 'blue' then
doTweenX('andlastly2','bluechard',500,50)
doTweenAlpha('andlive2','bluechard',1,5)
end
end

function doTweenScale(tag,obj,x,y,time,ease)
doTweenX(tag..'x',obj..'.scale',x,time,ease)
doTweenY(tag..'y',obj..'.scale',y,time,ease)
end
function onSongStart()
setProperty('isCameraOnForcedPos', true)
setProperty('camFollow.y',1475)
setProperty('camFollow.x',1750)
setProperty('cameraSpeed',1)
end

function onCreate()
doTweenZoom('camGamehihi','camGame',1.5,0.001)
setBlendMode('strumbg','')
-- background shit
makeLuaSprite('bg', 'backgrounds/funnyfellow/funnyfellowbgbetter',-100,290)
setProperty('bg.alpha',0.25)
addLuaSprite('bg')

makeLuaSprite('spag','backgrounds/funnyfellow/spagparticle',-350,400)
scaleObject('spag',7,4)
setBlendMode('spag','add')
setProperty('spag.color',getColorFromHex('9647ff'))
setProperty('spag.alpha',0)
addLuaSprite('spag')

makeAnimatedLuaSprite('goldenapple','backgrounds/funnyfellow/goldenapple',1140,1250)
addAnimationByPrefix('goldenapple','idle','goldenapple instance 10',24,true)
addLuaSprite('goldenapple')

makeAnimatedLuaSprite('yoshiegg','backgrounds/funnyfellow/yoshiegg',1405,1287.5)
addAnimationByPrefix('yoshiegg','idle','Symbol 5 instance 10',24,false)
addLuaSprite('yoshiegg')

makeAnimatedLuaSprite('tomatoe','backgrounds/funnyfellow/tomatoe',1950,1250)
addAnimationByPrefix('tomatoe','idle','tomatro instance 10',12,true)
addLuaSprite('tomatoe')

makeAnimatedLuaSprite('sticky','backgrounds/funnyfellow/sticky',2165,1265)
addAnimationByPrefix('sticky','idle','Symbol 15 instance 10',24,false)
addLuaSprite('sticky')

makeAnimatedLuaSprite('flowers','backgrounds/funnyfellow/flowers',540,1100)
addAnimationByPrefix('flowers','idle','Symbol 6 instance 10',24,false)
addLuaSprite('flowers')

makeAnimatedLuaSprite('bombeyepatch','backgrounds/funnyfellow/bombeyepatch',2650,1525)
addAnimationByPrefix('bombeyepatch','idle','Symbol 7 instance 10',24,true)
addLuaSprite('bombeyepatch',true)
setScrollFactor('bombeyepatch',1.1,1.1)

if not hideCards then
makeLuaSprite('f', 'rendersnlogos/animaticrenderagain',300,25)
setProperty('f.alpha',0)
scaleObject('f',0.65,0.65)
setObjectCamera('f','camHUD')
addLuaSprite('f',true)

makeLuaSprite('logos', 'rendersnlogos/funnyfellowtitle',0,0)
scaleObject('logos',0.5,0.5)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',true)
end

makeLuaSprite('v', 'backgrounds/oneshot/vignette',0,0)
setObjectCamera('v','camHUD')
addLuaSprite('v',true)
end

function onBeatHit()
if curBeat % 2 == 0 then
for _, anim in ipairs({'yoshiegg','sticky','flowers'}) do objectPlayAnimation(anim,'idle') end
elseif curBeat % 1 == 0 then
if spaghettiEvent == true then
SpaghettiBop()
triggerEvent('Trigger','shaderBop','')
triggerEvent('Add Camera Zoom','','')
end

end
end

function onCreatePost()
setObjectOrder('gfGroup',getObjectOrder('boyfriendGroup')+1)
for _, anim in ipairs({'yoshiegg','goldenapple','sticky','flowers','tomatoe','iconP1','iconP2','healthBar','dad'}) do setProperty(anim..'.alpha',0.005) end
end

function onEvent(n,v1)
if n == 'Trigger' then
if v1 == 'renderin' then
setProperty('isCameraOnForcedPos',false)
cameraFlash('camHUD', 'FFFFFF',0.5);
doTweenZoom('camGamehihi2','camGame',getProperty('defaultCamZoom'),0.001)
setProperty('camZooming',true)
removeLuaSprite('v')

for _, anim in ipairs({'yoshiegg','goldenapple','sticky','flowers','tomatoe','iconP1','healthBar','bg','textmiss','textacc'}) do setProperty(anim..'.alpha',1) end

doTweenAlpha('logoshit','logos',1,2,'quadOut')
doTweenX('scalelogox','logos.scale',1,15,'sineOut')
doTweenY('scalelogoy','logos.scale',1,15,'sineOut')

doTweenAlpha('logoshit3','f',1,2,'quadOut')
doTweenX('logoshit5','f',600,1.75,'circOut')
elseif v1 == 'renderout' then
doTweenAlpha('logoshit2','logos',0,2,'quadOut')
doTweenX('logoshit6','f',1675,1.75,'circIn')
doTweenAlpha('logoshit7','f',0,2.2,'quadOut')
elseif v1 == 'animatic' then
setProperty('dad.alpha',1)
setProperty('iconP2.alpha',1)
triggerEvent('Play Animation','start','dad')

setProperty('camZooming',false)
setProperty('cameraSpeed',100)
setProperty('camFollow.y',775)
setProperty('camFollow.x',150)
setProperty('cameraSpeed',1)
doTweenX('camX3', 'camFollow',1225,1,'cubeInOut')
setProperty('camGame.zoom',1.3)
doTweenZoom('camGamehihi2','camGame',getProperty('defaultCamZoom'),1.75,'cubeInOut')
elseif v1 == 'spaghetti' then
spaghettiEvent = true
setProperty('spag.alpha',1)
for _, anim in ipairs({'yoshiegg','goldenapple','sticky','flowers','tomatoe','dadGroup','boyfriend','bg','bombeyepatch','gf'}) do setProperty(anim..'.color',getColorFromHex('a8a8a8')) end
setProperty('isCameraOnForcedPos', true)
setProperty('cameraSpeed',1000)
setProperty('camFollow.y',1350)
setProperty('camFollow.x',1400)
setProperty('defaultCamZoom',0.65)
doTweenZoom('camGameelastic','camGame',getProperty('defaultCamZoom'),1.75/2,'elasticOut')
elseif v1 == 'bombeye' then
doTweenX('bombshit','bombeyepatch',-1000,17.5)
elseif v1 == 'camera' then
setProperty('isCameraOnForcedPos', false)
triggerEvent('CamZoom','-0.2','')
triggerEvent('setAngle','0','')
spaghettiEvent = false
elseif v1 == 'spagback' then
spaghettiEvent = true
setProperty('spag.visible',true)
triggerEvent('CamZoom','0.1','')
elseif v1 == 'spagend' then
setProperty('isCameraOnForcedPos', false)
setProperty('defaultCamZoom',0.8)
setProperty('cameraSpeed',1)
spaghettiEvent = false
for _, anim in ipairs({'yoshiegg','goldenapple','sticky','flowers','tomatoe','dadGroup','boyfriend','bg','bombeyepatch'}) do doTweenColor(anim,anim,getColorFromHex('ffffff'),1.25,'cubeOut') end
elseif v1 == 'spagback2' then
spaghettiEvent = true
setProperty('spag.visible',true)
triggerEvent('CamZoom','0.1','')
setProperty('isCameraOnForcedPos', true)
setProperty('cameraSpeed',1000)
setProperty('camFollow.y',1350)
setProperty('camFollow.x',1400)
setProperty('defaultCamZoom',0.65)
elseif v1 == 'end' then
setProperty('cameraSpeed',1000)
setProperty('camFollow.y',1350)
setProperty('camFollow.x',1400)
setProperty('defaultCamZoom',0.7)
doTweenX('sadgrouo','dadGroup',-2500,5,'cubeIn')
end
end
end

colourArray = {'9647ff','ff6ef1','0099FF','0000CC'}
colour = 1
function SpaghettiBop()
colour = colour+1
if colour > 4 then
colour = 1
end

cancelTween('spagdie')
setProperty('spag.alpha',0.75)
setProperty('spag.color',getColorFromHex(colourArray[colour]))
doTweenAlpha('spagdie','spag',0,1.25,'cubeOut')
end
local start = false
local focus = false
local nobop = false

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'startstuff' then
setProperty('gf.alpha',0)
doTweenColor('start','video','FFFFFF',6.5,'quadIn')
elseif name == 'Trigger' and v1 == 'start' then
startTween('blackgo','black',{alpha = 0},3,{startDelay = 1.5, ease = 'quadIn'})
startTween('videostuff3','video',{x = 1000},3,{startDelay = 1.9, ease = 'cubeInOut'})
doTweenX('videostuff','video.scale',2,3.5,'expoIn')
doTweenY('videostuff2','video.scale',2,3.5,'expoIn')
elseif name == 'Trigger' and v1 == 'thisisjustforblack' then
removeLuaSprite('video')
setProperty('camZooming',true)

elseif name == 'Trigger' and v1 == 'textdie' then
doTweenAlpha('start','camHUD',1,1.5,'quadOut')
elseif name == 'Trigger' and v1 == 'trans1' then
setProperty('isCameraOnForcedPos',true)
doTweenColor('bg1skydie','bg1sky','8d886e',15,'quadOut')
doTweenColor('bg1skydie2','bg1c','8d886e',15,'quadOut')
doTweenColor('bg1skydie3','bg1ef','8d886e',15,'quadOut')
doTweenX('camXnew', 'camFollow',1750,6.55,'expoIn')
doTweenY('camYnew', 'camFollow',900,6.55,'expoIn')

elseif name == 'Trigger' and v1 == 'eviltrans' then
setProperty('blackk.visible',true)
cancelTween('bg1skydie')
cancelTween('bg1skydie2')
cancelTween('bg1skydie3')
doTweenAlpha('bye6','bg1sky',0,0.245,'quadOut')
doTweenAlpha('bye7','bg1c',0,0.245,'quadOut')
doTweenAlpha('bye8','bgef',0,0.245,'quadOut')
cancelTween('camYnew')
cancelTween('camXnew')
setProperty('isCameraOnForcedPos',false)
elseif name == 'Trigger' and v1 == 'yoylefake' then
cancelTween('red')
if getProperty('cpuControlled') == true then
setProperty('botplayTxt.visible',true)
end

if not hideHud then
for _, hudout3 in ipairs({'scoreTxt','iconP1','iconP2','healthBar','textmiss','textacc','reddot','redline','timeTxt'}) do setProperty(hudout3..'.visible',true) setProperty(hudout3..'.alpha',1) end
setProperty('timeTxt.alpha',0.5)
end

for _, hudout2 in ipairs({'bars','h','table','michael','lava','center','center2','center3'}) do setProperty(hudout2..'.alpha',1) end

for _, hudout4 in ipairs({'d','bg1c','fire2','bg1sky','bg1grass','bg1ef','bg1grass2','brc','det'}) do setProperty(hudout4..'.alpha',0) removeLuaSprite(hudout4) end

start = true
runHaxeCode([[
for (strum in game.opponentStrums)
{
strum.cameras = [game.camGame];
strum.scrollFactor.set(1.1, 1.1);
strum.alpha = 1;
}
for (note in game.unspawnNotes) 
{
if (!note.mustPress) {
note.cameras = [game.camGame];
note.scrollFactor.set(1.1, 1.1);
note.alpha = 1;
} 
};
]])

setProperty('dad.x',getProperty('dad.x')-70)
setProperty('boyfriend.x',getProperty('boyfriend.x')+75)
setProperty('blackk.alpha',0.25)
setProperty('red.alpha',0.75)
setProperty('fire.visible',true)
setProperty('fire3.visible',true)
cameraFlash('camHUD', 'FF0000',1);
doTweenZoom('camhudmove','camHUD',1,0.01)
for i = 4,7 do
if not downscroll then
noteTweenY('note2'..i..'',i,50,0.01,'linear')
else
noteTweenY('noteu2'..i..'',i,575,0.01,'linear')
end
end
for i = 0,3 do 
if downscroll then
noteTweenY("NoteMove223"..i.."",i,2795, 0.001)
else
noteTweenY("NoteMove223"..i.."",i,895, 0.001)
end
end
elseif name == 'Trigger' and v1 == 'renderin' then
doTweenAlpha('fire2logo','fire2',1,1.25,'quadOut')
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenAlpha('logoshit2','logo',0,2,'quadOut')
doTweenAlpha('fire3logo','fire2',0,1.25,'quadOut')
elseif name == 'Trigger' and v1 == 'oldback' then
setProperty('defaultCamZoom',0.8)
cameraFlash('camGame','000000',1)
removeLuaSprite('michael')
removeLuaSprite('lava')
setProperty('sky.alpha',1)
setProperty('fy.alpha',1)
setProperty('dad.y',getProperty('dad.y')-30)
for _, hudout2 in ipairs({'bars','center','center2','center3','red'}) do setProperty(hudout2..'.alpha',0) end
setProperty('fire.visible',false)
setProperty('fire3.visible',false)
for i = 0,3 do
noteTweenAlpha("Notealpha5"..i.."",i,0,1.5,'quadOut')
end
elseif name == 'Trigger' and v1 == 'yoylespook' then
nobop = true
startTween('zoom2', 'camGame', {zoom = 0.625},12.5,{ease = 'cubeInOut'})
setProperty('defaultCamZoom',0.625)
removeLuaSprite('sky')
setProperty('blackk.alpha',0.75)
doTweenAlpha('red2','blackk',0.25,0.945,'quadOut')
elseif name == 'Trigger' and v1 == 'flashandstop' then
cancelTween('zoom2')
setProperty('isCameraOnForcedPos', true)
setProperty('camZooming',false)
doTweenX('camthing1', 'camFollow',1500,4.5,'cubeInOut')
doTweenY('camthing2', 'camFollow',800,2.5,'cubeInOut')
startTween('zoomnew', 'camGame', {zoom = 3},3.5,{ease = 'cubeInOut'})
setProperty('defaultCamZoom',3)
elseif name == 'Trigger' and v1 == 'backsturned' then
nobop = false
setProperty('isCameraOnForcedPos', true)
setProperty('camZooming',true)
setProperty('defaultCamZoom',1)
doTweenX('camX3', 'camFollow',getProperty('boyfriend.x')+200,0.5,'cubeInOut')
doTweenY('camY4', 'camFollow',getProperty('boyfriend.y'),0.5,'cubeInOut')

removeLuaSprite('fy')
removeLuaSprite('table')

setProperty('dad.x',getProperty('dad.x')+830)
setProperty('blackk.alpha',0.25)
setProperty('fire.visible',false)
setProperty('fire3.visible',false)
elseif name == 'Trigger' and v1 == 'dadfade' then
doTweenAlpha('dadshitdie','dad',0,0.75,'quadOut')
makeGraphic('blacks',1280,720,'000000')
doTweenAlpha('blacks','blacks',0.5,1.25/3,'circOut')
elseif name == 'Trigger' and v1 == 'redzoom' then
cameraFlash('camHUD','FF0000',1)
setProperty('defaultCamZoom',0.9)
doTweenZoom('camGamehah','camGame',getProperty('defaultCamZoom'),1.5,'circOut')
doTweenX('camX4', 'camFollow',getProperty('boyfriend.x')-175,1.5,'cubeInOut')
doTweenY('camY5', 'camFollow',getProperty('boyfriend.y')+50,2.5,'cubeInOut')

cancelTween('dadshitdie')
cancelTween('dadshitdie2')
cancelTimer('changestuff')

setProperty('dad.x',getProperty('dad.x')+630)
setProperty('dad.y',getProperty('dad.y')-150)
setProperty('dad.alpha',1)

setProperty('red.alpha',0.5)
setProperty('red.angle',7.5)
setProperty('white.angle',7.5)

doTweenAlpha('blacksend','blacks',0,1.25/4,'cubeOut')
elseif name == 'Trigger' and v1 == 'blockylockin' then
doTweenZoom('camGamehah','camGame',1.35,12)
doTweenX('camX6', 'camFollow',getProperty('boyfriend.x')+100,12.5,'cubeInOut')
doTweenY('camY8', 'camFollow',getProperty('boyfriend.y')+150,12.5,'cubeInOut')
doTweenAlpha('blacks3','blacks',0.75,12)
elseif name == 'Trigger' and v1 == 'prelyrics' then
if getProperty('cpuControlled') == true then
setProperty('botplayTxt.visible',false)
end
setProperty('black.alpha',1)
removeLuaSprite('blacks')
setProperty('camZooming',false)
if not hideHud then
for _, hudout2 in ipairs({'iconP1','iconP2','healthBar','textmiss','textacc','scoreTxt'}) do doTweenAlpha('hud'..hudout2,hudout2,0,0.75,'quadOut') end
end
setProperty('strumbg.alpha',0.01)
setProperty('bars.alpha',0.01)
for i = 4,7 do
noteTweenAlpha("Notealpha"..i.."",i,0,1.5,'quadOut')
end
elseif name == 'Trigger' and v1 == 'fadebackin' then
if getProperty('cpuControlled') == true then
setProperty('botplayTxt.visible',true)
end
runTimer('flicker1',getRandomInt(4.4,4.9))
runTimer('swappranks',1)
setProperty('defaultCamZoom',0.45)
doTweenZoom('camGamehah','camGame',0.45,5,'expoInOut')
doTweenX('camX176', 'camFollow',getProperty('boyfriend.x')-400,3.5,'cubeInOut')
doTweenY('camY178', 'camFollow',getProperty('boyfriend.y')+75,2.5,'cubeInOut')
setProperty('boyfriendGroup.y',getProperty('boyfriendGroup.y')-20)
setProperty('canPause',true)

setProperty('fire.visible',true)
setProperty('fire3.visible',true)

for _, hudout2 in ipairs({'bars','textmiss','textacc','scoreTxt','platform','platform2','tv','tvf','frame'}) do doTweenAlpha('hud2'..hudout2,hudout2,1,1.5,'quadOut') end
doTweenAlpha('iconPDIE19','strumbg',strumBGAlpha,1.5,'quadOut')
for i = 0,7 do
noteTweenAlpha("Notealpha22"..i.."",i,1,1.25,'quadOut')
end
elseif name == 'Trigger' and v1 == 'lyrics' then
setProperty('canPause',false)
removeLuaSprite('red')
setProperty('black.alpha',0)
elseif name == 'Trigger' and v1 == 'backintoit' then
setProperty('defaultCamZoom',0.4)
doTweenZoom('camGamehah2','camGame',0.4,5,'expoInOut')
setProperty('camZooming',false)
setProperty('isCameraOnForcedPos',false)
elseif name == 'Trigger' and v1 == 'ending' then
setProperty('defaultCamZoom',1.5)
doTweenZoom('camGamehah3','camGame',1.5,0.5)
setProperty('isCameraOnForcedPos',true)
doTweenX('camX7', 'camFollow',getProperty('dad.x')+100,0.35,'expoInOut')
doTweenY('camY9', 'camFollow',getProperty('dad.y')+200,0.5,'expoInOut')
doTweenAlpha('camHUDdie','camHUD',0,0.4)
doTweenAlpha('camHUDdie2','flash',1,0.4)
setProperty('camZooming',false)
elseif name == 'Trigger' and v1 == 'endingout' then
doTweenAlpha('camHUDdie3','flash',0,1.5)
setProperty('camGame.visible',false)
setProperty('camZooming',false)
setProperty('canPause',false)

for _, hudout2 in ipairs({'timeTxt','time','time2'}) do setProperty(hudout2..'.alpha',0) end
elseif name == 'dumb video' and v1 == 'yoylefake2' then
for _, hudout2 in ipairs({'flash','camGame','camHUD','blackk'}) do setProperty(hudout2..'.visible',false) end
elseif name == 'Trigger' and v1 == 'blackout' then
doTweenAlpha('blacks','blacks',0.5,1.25/3,'circOut')
elseif name == 'Trigger' and v1 == 'blackoutend' then
doTweenAlpha('blacksend','blacks',0,1.25/4,'cubeOut')
elseif name == 'Trigger' and v1 == 'blackoutlong' then
doTweenAlpha('blacks2','blacks',0.5,2.5)
elseif name == 'Trigger' and v1 == 'blackoutredend' then
makeGraphic('blacks',1280,720,'FF0000')
doTweenAlpha('blacksend2','blacks',0,1.25,'cubeOut')
end
end

function onUpdatePost(elapsed)
if nobop == true then
setProperty('camZooming',false)
end
end
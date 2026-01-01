camstop = nil
coolway = false
bop = 1
characterArray = {'taco','nick','knife'}

function onSongStart()
for i = 0, #characterArray do
objectPlayAnimation(characterArray[i],'idle')
end
end

function onCreate() 
setProperty('camGame.bgColor', getColorFromHex('2c2b36'))
setProperty('textmiss.alpha',1)
setProperty('bars.alpha',1)

makeLuaSprite('sky','backgrounds/invitational/dd/Remaster Sky',1950,885)
setProperty('sky.alpha',1)
setScrollFactor('sky',0.85,0.85)
addLuaSprite('sky',false)

makeLuaSprite('gra','backgrounds/invitational/dd/Remaster Ground',2500,1920)
setProperty('gra.alpha',1)
addLuaSprite('gra',false)

-- characters
makeAnimatedLuaSprite('bookcase','backgrounds/invitational/dd/book won bfdia23',5000,1550)
addAnimationByPrefix('bookcase','idle','bookcasey bg instance 1',24,true)
setScrollFactor('bookcase',0.9,0.9)
addLuaSprite('bookcase',false)

makeLuaSprite('elim','backgrounds/invitational/dd/Remaster Elim Area',2825,1535)
setProperty('elim.alpha',1)
addLuaSprite('elim',false)

makeAnimatedLuaSprite('knife','backgrounds/invitational/dd/kinfe',3160,1867)
addAnimationByPrefix('knife','idle','Knife Eh instance 1',24,false)
addAnimationByPrefix('knife','idle2','Knife Happy instance 1',24,false)
addLuaSprite('knife',false)

makeAnimatedLuaSprite('taco','backgrounds/invitational/dd/taco cute',2890,2080)
addAnimationByPrefix('taco','idle','Taco Eh instance 1',24,false)
addAnimationByPrefix('taco','idle2','Taco Happy instance 1',24,false)
addLuaSprite('taco',false)

makeAnimatedLuaSprite('nick','backgrounds/invitational/dd/nickel not nick le',4285,2035)
addAnimationByPrefix('nick','idle','Nickel Eh instance 1',24,false)
addAnimationByPrefix('nick','idle2','Nickel Happy instance 1',24,false)
addLuaSprite('nick',false)
--

makeLuaSprite('spotlight','backgrounds/invitational/dd/spotlight',2950,200)
setBlendMode('spotlight','add')
setProperty('spotlight.alpha',0.001)
addLuaSprite('spotlight',true)

makeAnimatedLuaSprite('ddtrans','characters/invitational-dearest/bass stripping',635,-1875)
addAnimationByPrefix('ddtrans','dstrip','bassstrip instance 1',24,false)
setObjectCamera('ddtrans','camOther')
addLuaSprite('ddtrans',true)

makeAnimatedLuaSprite('mtrans','characters/invitational-dearest/mephonetransition',-81,1100)
addAnimationByPrefix('mtrans','mstrip','phonestrip',24,false)
setObjectCamera('mtrans','camOther')
addLuaSprite('mtrans',true)
if not hideCards then
makeLuaSprite('m', 'rendersnlogos/mephonerender',1250,50)
setProperty('m.alpha',0)
setObjectCamera('m','camHUD')
addLuaSprite('m',false)

makeLuaSprite('logos', 'rendersnlogos/dearestmixlogo',0,0)
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
scaleObject('logos',0.75,0.75)
screenCenter('logos','xy')
addLuaSprite('logos',true)
end
end

function onSectionHit()
if mustHitSection and coolway == true then
doTweenAngle('camGamecool','camGame',2.5,1.25,'cubeOut')
elseif not mustHitSection and coolway == true then
doTweenAngle('camGamecool2','camGame',-2.5,1.25,'cubeOut')
end
end

function onUpdatePost(elapsed)
if camstop == true then
setProperty('camZooming',false)
end
end

function onEvent(name,v1)
if name == 'Trigger' and v1 == 'renderin' then
doTweenX('logoshit5','m',800,1.75,'circOut')
doTweenAlpha('logoshit3','m',1,2,'quadOut')
doTweenAlpha('logoshit','logos',1,3,'quadOut')
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenX('logoshit6','m',1300,2,'quadIn')
doTweenAlpha('logoshit4','m',0,2,'quadOut')
doTweenAlpha('logoshit2','logos',0,1,'quadOut')
elseif name == 'Trigger' and v1 == 'zoomstart' then
doTweenZoom('camgamewow','camGame',1.5,7,'cubeIn')
camstop = true
elseif name == 'Trigger' and v1 == 'strip' then
setProperty('ddtrans.y',-2275)
setProperty('mtrans.y',1100)
setProperty('ddtrans.x',635)
setProperty('mtrans.x',-81)
doTweenY('coolstrip1','ddtrans',-600,0.75,'circOut')
doTweenY('coolstrip2','mtrans',-600,0.75,'circOut')
objectPlayAnimation('mtrans','mstrip')
objectPlayAnimation('ddtrans','dstrip')
elseif name == 'Trigger' and v1 == 'stripend' then
doTweenX('coolstripend1','ddtrans',getProperty('ddtrans.x')+1000,0.75,'circInOut')
doTweenX('coolstripend2','mtrans',getProperty('mtrans.x')-1000,0.75,'circInOut')
coolway = true
camstop = false
elseif name == 'Trigger' and v1 == 'coolwayend' then
coolway = false
cancelTween('camGamecool')
cancelTween('camGamecool2')
doTweenZoom('camGamezoomout','camGame',0.8,2.5,'cubeInOut')
setProperty('defaultCamZoom',0.8)
doTweenAngle('camGamecool3','camGame',0,2.5,'cubeOut')
elseif name == 'Trigger' and v1 == 'intermission' then
setProperty('isCameraOnForcedPos', true)
doTweenAlpha('camHUDdie','camHUD',0,3.25,'sineOut')
doTweenX('camfollowx','camFollow',3800,3,'sineInOut')
doTweenY('camfollowy','camFollow',1950,3,'sineInOut')
setProperty('camZooming',false)
 for _, bgout in ipairs({'sky','gra'}) do doTweenAlpha('bgwin2'..bgout,bgout,1,9,'circOut') end
doTweenAlpha('spotdie','spotlight',0,1.5)
elseif name == 'Trigger' and v1 == 'intermissionend' then
doTweenAlpha('camHUDdie2','camHUD',1,1.25,'sineIn')
setProperty('isCameraOnForcedPos', false)
elseif name == 'Trigger' and v1 == 'spotlight' then
setProperty('spotlight.y',200)
 for _, bgout in ipairs({'sky','gra'}) do doTweenAlpha('bg'..bgout,bgout,0.5,3) end
doTweenAlpha('spotin','spotlight',1,7.5)
doTweenY('spotin2','spotlight',1200,5,'cubeOut')
elseif name == 'Trigger' and v1 == 'trapsection' then
camstop = true
 for _, bgout in ipairs({'sky','gra'}) do doTweenAlpha('bgwin'..bgout,bgout,1,3,'circOut') end
doTweenAlpha('spotdie','spotlight',0,1.25)

setProperty('isCameraOnForcedPos', true)
doTweenZoom('camGamezoomout2','camGame',5.2,3,'sineIn')
setProperty('defaultCamZoom',5.2)

doTweenX('camfollowx2','camFollow',3700,1,'sineInOut')
doTweenY('camfollowy2','camFollow',1750,1,'sineInOut')
elseif name == 'Trigger' and v1 == 'out' then
camstop = false
cancelTween('camGamezoomout2')
setProperty('defaultCamZoom',1.25)
 for _, bgout2 in ipairs({'sky','gra','elim','taco','knife','nick'}) do setProperty(bgout2..'.alpha',0.001) end
setProperty('gfGroup.alpha',0.001)
doTweenY('camfollowy2','camFollow',1950,1,'sineInOut')
elseif name == 'Trigger' and v1 == 'back' then
setProperty('spotlight.y',200)
 for _, bgout in ipairs({'sky','gra','elim'}) do setProperty(bgout..'.alpha',1) doTweenAlpha('bg3'..bgout,bgout,1,3) end
 for _, characters in ipairs({'knife','taco','nick'}) do setProperty(characters..'.alpha',1) bop = 2 end
doTweenAlpha('spotin','spotlight',1,7.5)
doTweenY('spotin2','spotlight',1200,5,'cubeOut')
setProperty('gfGroup.alpha',1)
setProperty('isCameraOnForcedPos', false)
setProperty('defaultCamZoom',0.8)
doTweenX('bookcasey','bookcase',2000,25)
elseif name == 'Trigger' and v1 == 'endbutspot' then
coolway = false
cancelTween('camGamecool')
cancelTween('camGamecool2')
doTweenZoom('camGamezoomout','camGame',0.8,2.5,'cubeInOut')
setProperty('defaultCamZoom',0.8)
doTweenAngle('camGamecool3','camGame',0,2.5,'cubeOut')
end
end

function onBeatHit()
for i = 0, #characterArray do
if curBeat % 2 == 0 and bop == 1 then
objectPlayAnimation(characterArray[i],'idle')
elseif curBeat % 2 == 0 and bop == 2 then
objectPlayAnimation(characterArray[i],'idle2')
end
end
end
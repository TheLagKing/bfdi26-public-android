function onCreate() 
setProperty('camGame.bgColor', getColorFromHex('00FF00'))

makeLuaSprite('backg','backgrounds/cyan/background',-5,10)
setScrollFactor('backg',0,0)
scaleObject('backg',2.5,2.5)
screenCenter('backg','xy')
addLuaSprite('backg')

makeLuaSprite('flip','backgrounds/cyan/flipacliplogoforcorner',0,525)
scaleObject('flip',0.35,0.35)
setObjectCamera('flip','other')
addLuaSprite('flip')
end

function onCreatePost()
setProperty('textmiss.alpha',1)
setProperty('textacc.alpha',1)
setProperty('iconP1.flipX',true)

setProperty('isCameraOnForcedPos', true)
setProperty('camFollow.y',125)
setProperty('camFollow.x',1125)
end

function onUpdatePost(elapsed)
setProperty('camZooming',false)
end
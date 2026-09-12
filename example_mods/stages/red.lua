function onCreate()
makeLuaSprite('bag','characters/euthanized/punchingbag',550,-1300)
setScrollFactor('bag',0.9,0.9)
addLuaSprite('bag')
setProperty('textmiss.alpha',1)

if not hideCards then
makeLuaSprite('k','rendersnlogos/redgolfballsauce',650,235)
setObjectCamera('k','camOther')
scaleObject('k',0,0)
addLuaSprite('k',false)

makeLuaSprite('logos','rendersnlogos/euthanizedtitle',0,425)
setObjectCamera('logos','camOther')
scaleObject('logos',0,0)
screenCenter('logos','x')
addLuaSprite('logos',false)
end
end

shit = false
function onUpdatePost()
songPos = getSongPosition()
doTweenAngle('imthealpha','bag',0+0.75*math.sin((songPos/3000) * (bpm/45) *1),0.01)
if shit == true then
doTweenY('imthey','bag',-401.75+1.75*math.sin((songPos/3000) * (bpm/60) *1),0.01)
end
end


function onEvent(n,v1)
if n == 'Trigger' then
if v1 == 'comedown' then
doTweenY('tweencool','bag',-400,5,'quintOut')
end
end
end

function onTweenCompleted(tag)
if tag == 'tweencool' then
cancelTween('tweencool')
shit = true
end
end
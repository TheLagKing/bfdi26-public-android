camhudrand = 1

function onCreate() 
setProperty('camGame.bgColor', getColorFromHex('FFFFFF'))

if songName == 'blue-golfball-bf' then
setProperty('defaultCamZoom',0.7)
setProperty('textmiss.alpha',1)

makeLuaSprite('hue', '', 0, 0);
setProperty('hue.alpha',0)
addLuaSprite('hue',false);

makeLuaSprite('smoke', '',-500,0)
makeGraphic('smoke',1280,720,'000000')
setSpriteShader('smoke','bgbbfm')
setProperty('smoke.visible',false)
setBlendMode('smoke','multiply')
scaleObject('smoke',2,2)
addLuaSprite('smoke',true)
if not hideCards then
makeLuaSprite('b', 'rendersnlogos/bgb render',-750,20)
setProperty('b.alpha',1)
scaleObject('b',0.65,0.65)
setObjectCamera('b','camHUD')
addLuaSprite('b',false)

makeLuaSprite('logos', 'rendersnlogos/bgb bf mix P1',500,0)
scaleObject('logos',0.75,0.75)
screenCenter('logos','y')
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',true)

makeLuaSprite('logos2', 'rendersnlogos/bgb bf mix P2',850,350)
scaleObject('logos2',0.75,0.75)
setProperty('logos2.alpha',0)
setObjectCamera('logos2','camHUD')
addLuaSprite('logos2',true)
end
else
if not hideCards then
makeLuaSprite('renders', 'rendersnlogos/sourapplerender',-150,600)
setProperty('renders.angle',-25)
scaleObject('renders',0.5,0.5)
setProperty('renders.alpha',0)
setObjectCamera('renders','camHUD')
addLuaSprite('renders',true)

makeLuaSprite('renderb', 'rendersnlogos/bluegolfballrender',725,-400)
setProperty('renderb.angle',25)
scaleObject('renderb',0.5,0.5)
setProperty('renderb.alpha',0)
setObjectCamera('renderb','camHUD')
addLuaSprite('renderb',true)

makeLuaSprite('logos2', 'rendersnlogos/bluegbcredits',125,335)
scaleObject('logos2',0.5,0.5)
screenCenter('logos2','x')
setProperty('logos2.alpha',0)
setObjectCamera('logos2','camHUD')
addLuaSprite('logos2',true)

makeLuaSprite('logos', 'rendersnlogos/bluegbtitle',25,0)
scaleObject('logos',0.5,0.5)
screenCenter('logos','xy')
setProperty('logos.alpha',0)
setObjectCamera('logos','camHUD')
addLuaSprite('logos',true)
end
end
end

function onCreatePost()
if songName == 'blue-golfball-bf' and (shadersEnabled) then
initLuaShader("bgbbfm");
end
end

function onEvent(name,v1)
if songName == 'blue-golfball-bf' and name == 'Trigger' then
if v1 == 'CAMRANDOM' then
setProperty('camHUD.x',getRandomInt(-250,150))
setProperty('camHUD.y',getRandomInt(-250,150))
triggerEvent('Add Camera Zoom','','')
triggerEvent('Screen Shake','0,0','0.25,0.00150')
end
end
end

function onUpdatePost()
if songName == 'blue-golfball-bf' and (shadersEnabled) then
setShaderFloat('smoke','iTime',os.clock())
if getProperty('hue.alpha') == 1 then
setProperty('smoke.visible',true)
end
end
end

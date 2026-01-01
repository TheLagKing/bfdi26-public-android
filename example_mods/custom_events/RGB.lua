amount = 0
local ColorArray = {'8FCBE2','C74C5F','FF9B32','FFE75D','8ECA73'}
local Color = 1

function onCreate()
	  makeLuaSprite('flashg', 'backgrounds/hey-two/addeffect', 0, 0);
		setProperty('flashg.alpha',0)
	  setBlendMode('flashg', 'add')
	  setObjectCamera('flashg', 'hud')
	  addLuaSprite('flashg')
end

function onEvent(n,v1,v2)
	if n == 'RGB' then
		Color = getRandomInt(1, #ColorArray, Color)
		setProperty('black.color','FFFFFF')
		setProperty('black.color',getColorFromHex(ColorArray[Color]))
triggerEvent("Add Camera Zoom", 0.015 % 2, 0.0015)

setProperty('flashg.alpha',0.5)
doTweenAlpha('flTw','flashg',0,0.75,'linear')
end
end
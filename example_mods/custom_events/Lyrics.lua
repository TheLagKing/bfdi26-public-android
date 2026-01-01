function onCreatePost()
    makeLuaSprite("bg", null, 0, 484)
    makeGraphic("bg", 500, 32.5, '000000')
    screenCenter("bg", 'x')
    setObjectCamera("bg", 'Other')
    addLuaSprite("bg", true)
    setProperty("bg.alpha", 0)

	makeLuaText('textt', '',1000,0,getProperty('bg.y') + 6)
	setObjectCamera('textt', 'Other')
	setProperty('textt.alpha',1)
	setTextFont('textt','Roboto-Regular.TTF')
	setTextBorder('textt','000000',0)
	setTextSize('textt',32.5)
addLuaText('textt',false)
end

function onEvent(n,v1,v2)
if not hideSub then
	if n == 'Lyrics' then
		setProperty('textt.alpha',1)
		runTimer('bye',1.25)
		setTextString('textt',v1)
		setProperty("bg.alpha", 0.6)
		setGraphicSize('bg', getProperty('textt.textField.textWidth')+35, getProperty('textt.textField.textHeight') + 20)
		screenCenter('bg', 'x')
		screenCenter('textt','x')

	if v1 == '' then
		setProperty("bg.alpha",0)
		setTextString('textt',v1)
	end
end
end
end

function onTimerCompleted(tag)
if tag == 'bye' then
	setProperty("bg.alpha",0)
	setTextString('textt','')
end
end
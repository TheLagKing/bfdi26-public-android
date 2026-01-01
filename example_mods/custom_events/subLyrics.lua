local dad = false
local bf = false


function onCreatePost()
    makeLuaSprite("bg2", null, 0, 542)
    makeGraphic("bg2", 500, 32.5, '000000')
    screenCenter("bg2", 'x')
    setObjectCamera("bg2", 'Other')
    addLuaSprite("bg2", true)
    setProperty("bg2.alpha", 0)

	makeLuaText('textt2', '',1000,0,getProperty('bg2.y') + 6)
	setObjectCamera('textt2', 'Other')
	setProperty('textt2.alpha',1)
	setTextFont('textt2','Roboto-Regular.TTF')
	setTextBorder('textt2','000000',0)
	setTextSize('textt2',27.5)
addLuaText('textt2',false)
end

function onEvent(n,v1,v2)
if not hideSub then
	if n == 'subLyrics' then
		cancelTween('1bye2')
		setProperty('textt2.alpha',1)
		runTimer('bye2',1.25)
		setTextString('textt2',v1)
		setProperty("bg2.alpha", 0.6)
		setGraphicSize('bg2', getProperty('textt2.textField.textWidth')+35, getProperty('textt2.textField.textHeight') + 20)
        screenCenter('bg2', 'x')
		screenCenter('textt2','x')

	if v1 == '' then
		setProperty("bg2.alpha",0)
		setTextString('textt2',v1)
	end
end
end
end

function onTimerCompleted(tag)
if tag == 'bye2' then
	setProperty("bg2.alpha",0)
	setTextString('textt2','')
end
end
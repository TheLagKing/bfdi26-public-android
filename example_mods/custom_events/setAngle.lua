function onEvent(name,v1,v2)
	if name == 'setAngle' then
	local split2 = stringSplit(v2, ',')
	local time = (split2[1])
	local ease = (split2[2])

	if v2 == '' then
	time = 1.25
	ease = 'cubeOut'
	end

	cancelTween('customtagsothegamedoesntkillme')
	doTweenAngle('customtagsothegamedoesntkillme','camGame',v1,time,ease)
	end
end
function onEvent(name,v1,v2)
	if name == 'coolHUD' then
	local split1 = stringSplit(v1, ',')
	local angle = (split1[1])
	local zoom = (split1[2])

	local split2 = stringSplit(v2, ',')
	local time = (split2[1])
	local ease = (split2[2])

	if v2 == '' then
	time = 1.25
	ease = 'cubeOut'
	end

	cancelTween('customtagsothegamedoesntkillme')
	cancelTween('customtagsothegamedoesntkillme2')
	doTweenAngle('customtagsothegamedoesntkillme','camHUD',angle,time,ease)
	doTweenZoom('customtagsothegamedoesntkillme2','camHUD',zoom,time,ease)
	end
end
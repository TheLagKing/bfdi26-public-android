function onEvent(n,v1)
if n == 'Trigger' and v1 == 'thing' then
doTweenAlpha('camHUDcome','camHUD',1,1.25,'quintOut')
setProperty('camZooming',true)
startTween('cool', 'logos.scale', {x = 0.75, y = 0.75}, 1.75,{startDelay = 0.25, ease = 'quartOut'})
startTween('cool3', 'k.scale', {x = 0.65, y = 0.65}, 1.5,{startDelay = 0.15, ease = 'quartOut'})
startTween('bfmove','camFollow',{x = getMidpointX("boyfriend") - 100 - getProperty("boyfriend.cameraPosition[0]") + getProperty("boyfriendCameraOffset[0]"), y = getMidpointY("boyfriend") - 100 + getProperty("boyfriend.cameraPosition[1]") + getProperty("boyfriendCameraOffset[1]")},1.5,{ease = 'quartInOut'})
elseif n == 'Trigger' and v1 == 'thing2' then
startTween('cool2', 'logos.scale', {x = 0, y = 0}, 1,{startDelay = 2.5, ease = 'quintIn'})
startTween('cool4', 'k.scale', {x = 0, y = 0}, 0.9,{startDelay = 2.6, ease = 'quintInOut'})
end
end
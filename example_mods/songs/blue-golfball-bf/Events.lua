function onEvent(name,v1)
if name == 'Trigger' and v1 == 'sus' then -- hi gp
doTweenAlpha('logoshit3','b',1,2,'quadOut')
doTweenX('logoshit5','b',0,1.75,'circOut')
doTweenAlpha('logoshitqs','logos',1,1.75,'quadOut')
elseif name == 'Trigger' and v1 == 'renderin2' then
setProperty('logos2.alpha',1)
setProperty('logos2.y',375)
setProperty('logos.x',525)
doTweenX('logoss','logos',500,0.5,'circOut')
doTweenY('logos2s','logos2',350,0.5,'circOut')
doTweenAlpha('logoshit','logos',1,2,'quadOut')
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenX('logoshit6','b',-750,1.5,'quadIn')
doTweenAlpha('logoshit4','b',0,2,'quadOut')
doTweenAlpha('logoshit2','logos',0,2,'quadOut')
doTweenX('logoshita','logos2',1750,2,'cubeIn')
end
end
function onEvent(name,v1)
if name == 'Trigger' and v1 == 'renderin' then
doTweenAlpha('logoshit','renderb',1,1,'quadOut')
doTweenX('logoshit1','renderb',700,1.75,'circOut')
doTweenY('logoshit2','renderb',-25,1.5,'circOut')
doTweenAngle('logoshit3','renderb',0,1.5,'circOut')

doTweenAlpha('logoshit4','renders',1,1,'quadOut')
doTweenX('logoshit5','renders',-15,1.6,'circOut')
doTweenY('logoshit6','renders',360,1.5,'circOut')
doTweenAngle('logoshit7','renders',0,1.5,'circOut')


doTweenAlpha('logoshit8','logos',1,2,'quadOut')
elseif name == 'Trigger' and v1 == 'renderout' then
doTweenAlpha('logoshit9','logos2',1,2,'quadOut')
doTweenY('logoshit10','logos2',435,1.5,'circOut')
elseif name == 'Trigger' and v1 == 'renderout2' then
doTweenAlpha('logoshit11','logos',0,1)
doTweenAlpha('logoshit12','logos2',0,1)
doTweenAlpha('logoshit13','renders',0,1)
doTweenAlpha('logoshit14','renderb',0,1)
end
end
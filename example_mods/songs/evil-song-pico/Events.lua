function onEvent(n,v1)
if n == 'Trigger' and v1 == 'renderin' then
doTweenX('logoshit25','l',900,1.75,'circOut')
doTweenX('logoscalex2','logos.scale',1,1,'elasticOut')
doTweenY('logoscaley2','logos.scale',1,1,'elasticOut')
doTweenAlpha('logoshit2','logos',1,1,'quadOut')
elseif n == 'Trigger' and v1 == 'rendersour' then
doTweenX('logoshit225','s',-50,2.75,'circOut')
elseif n == 'Trigger' and v1 == 'renderout' then
doTweenAlpha('logoshit222','logos',0,2,'quadOut')
doTweenX('logoshit6','l',1500,2,'quadIn')
doTweenAlpha('logoshit4','l',0,2,'quadOut')

doTweenX('logoshit6223','s',-1000,2,'quadIn')
doTweenAlpha('logoshit42323','s',0,2,'quadOut')
end
end
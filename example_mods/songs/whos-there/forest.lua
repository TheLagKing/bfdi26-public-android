function onCreatePost()
    setBlendMode('strumbg','')
    for _, hudout in ipairs({'uiGroup','bars','textmiss','scoreTxt','textacc'}) do setProperty(hudout..'.alpha',0) end
    for p= 4,7 do noteTweenX('movePlayer'..p, p,1625 + (110 *(p - 4)), 0.25,'cubeInOut') end
end

function onSongStart()
    for p= 4,7 do noteTweenX('movePlayer'..p, p,1625 + (110 *(p - 4)), 0.0001,'cubeInOut') end
end

function onEvent(name,v1,v2)
    if name == '' then
        if v1 == 'note' then for i= 4,7 do noteTweenX('movePlayer2'..i, i,745 + (110 *(i - 4)), 1.25,'cubeOut') end
        elseif v1 == 'rr' then for _, hudout in ipairs({'uiGroup','bars','textmiss','scoreTxt','textacc'}) do setProperty(hudout..'.alpha',1) end setProperty('iconP2.alpha', 0) setProperty('iconP1.alpha', 0) setProperty('healthBar.alpha', 0) 
        elseif v1 == 'leafyappear' then setProperty('iconP2.alpha', 1) setProperty('iconP1.alpha', 1) setProperty('healthBar.alpha', 1) 
        elseif v1 == 'scare' then    
            for _, hudout in ipairs({'uiGroup','bars','textmiss','scoreTxt','textacc'}) do setProperty(hudout..'.alpha',0) end
            triggerEvent('Screen Shake','0.45,0.005','0.45,0.005')
            setProperty('camGame.alpha',0)
        elseif v1 == 'scareend' then    
            for _, hudout in ipairs({'uiGroup','bars','textmiss','scoreTxt','textacc'}) do setProperty(hudout..'.alpha',1) end
            setProperty('camGame.alpha',1)
        end
    end
end
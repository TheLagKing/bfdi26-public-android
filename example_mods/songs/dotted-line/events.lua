background1 = true
background2 = false
background3 = false

function onEvent(tag,v1)
if tag == 'Trigger' and v1 == 'spookytween' then
doTweenZoom('camGamesht3','camGame',2.051,2.75,'cubeInOut')
doTweenAlpha('vshitend2','v',0.75,1,'cubeInOut')
elseif tag == 'Trigger' and v1 == 'pause' then
setProperty('canPause',true)
doTweenY('1tween','1',50,4,'cubeInOut')
doTweenY('btween','b',50,3.95,'cubeInOut')
doTweenAlpha('logosalpja','logos',1,5,'cubeInOut')
doTweenAlpha('logosalpja2','1',1,5,'cubeInOut')
doTweenAlpha('logosalpja3','b',1,5,'cubeInOut')
elseif tag == 'Trigger' and v1 == 'renderout' then
doTweenY('1tween2','1',-750,4,'cubeInOut')
doTweenY('btween2','b',750,4,'cubeInOut')
doTweenAlpha('logosalpja4','logos',0,3,'cubeInOut')
doTweenAlpha('logosalpja5','1',0,3,'cubeInOut')
doTweenAlpha('logosalpja6','b',1,3,'cubeInOut')
elseif tag == 'Trigger' and v1 == 'background2' then
    cancelTween('camGamesht3')
    cancelTween('vshitend2')
    for _, backgroundsprite2 in ipairs({'sky','water','shelf','plant','chair','add','force'}) do
        setProperty(backgroundsprite2..'.alpha',1)
        setObjectOrder('dadGroup',getObjectOrder('chair')-1)
        removeLuaSprite('swirl')
        for i = 1,5 do
        cancelTween('starss'..i..'')
        cancelTween('stars'..i..'')
        cancelTween('stary'..i..'')
        cancelTween('stary2'..i..'')
        cancelTween('starz'..i..'')
        cancelTween('starz2'..i..'')
        removeLuaSprite('star'..i)
        end
setProperty('cameraSpeed',1)
        background1 = false
        background2 = true
    setProperty('bfPhantom.visible',false)
    setProperty('bfPhantom2.visible',false)
    setProperty('dadPhantom.visible',false)
    setProperty('dadPhantom2.visible',false)

    if not middlescroll then
        alreadySwapped = true
    for i = 0, 3 do
		j = (i + 4)

		iPos = _G['defaultPlayerStrumX'..i];
		jPos = _G['defaultOpponentStrumX'..i];
		if alreadySwapped then
				iPos = _G['defaultOpponentStrumX'..i];
				jPos = _G['defaultPlayerStrumX'..i];
		end
		noteTweenX('note'..i..'TwnX', i, iPos, 1.25, 'cubeInOut');
		noteTweenX('note'..j..'TwnX', j, jPos, 1.25, 'cubeInOut');
		end
end

    end

elseif tag == 'Trigger' and v1 == 'background3' then
    for _, background3 in ipairs({'skyb','ground','grass','grass2','grass3','grass4','land','grad'}) do
    setProperty(background3..'.alpha',1)
    background3 = true
    background2 = false

    for p= 4,7 do
        noteTweenX('movePlayer'..p, p,425 + (110 *(p - 4)), 3.25,'cubeInOut')
        end
    
        for p= 0,3 do
            noteTweenX('moveOpponent'..p, p,-850 + (115 *(p - 4)), 2.25,'cubeInOut')
            end
    end
    for _, backgroundsprite2 in ipairs({'sky','water','shelf','plant','chair','add','force'}) do
        removeLuaSprite(backgroundsprite2)
    end
    setObjectOrder('dadGroup',getObjectOrder('boyfriendGroup')+2)
    setObjectOrder('grad',getObjectOrder('boyfriendGroup')+1)
    setProperty('dadGroup.x',getProperty('dadGroup.x')+270)
    setProperty('boyfriendGroup.y',getProperty('boyfriendGroup.y')+420)
    setProperty('camGame.zoom',1.5)
    doTweenZoom('camGamesht','camGame',0.751,1.25,'quintInOut')
    setProperty('defaultCamZoom',0.7525)
    doTweenAlpha('vignetteendstuff','v',0.5,1,'quadOut')
    setProperty('isCameraOnForcedPos', true)
    setProperty('camFollow.x',610)
    setProperty('camFollow.y',310)
elseif tag == 'Trigger' and v1 == 'endtween' then
    doTweenZoom('camGamesht2','camGame',2.251,5.5,'cubeInOut')
    doTweenAlpha('vshitend','v',1,2,'cubeInOut')
end
end

function onTweenCompleted(tag)
if tag == 'camGamesht' then
setProperty('cameraSpeed',0)
end
end

function onSectionHit()
if not mustHitSection and background2 == true then
setProperty('defaultCamZoom',0.875)
doTweenAlpha('fogshitoh','v',1,2,'quadOut')
elseif mustHitSection and background2 == true then
setProperty('defaultCamZoom',0.651)
doTweenAlpha('fogshitoh2','v',0,0.5,'quadOut')
end
end

    function onUpdatePost()
    if background1 == true then
    songPos = getSongPosition()
    doTweenY('phantomymove','bfPhantom',bfphantomy+6.25*math.sin((songPos/1500) * (bpm/15) *0.75),0.01)
    doTweenX('phantomxmove','bfPhantom',bfphantomx+12.5*math.sin((songPos/1500) * (bpm/30) *0.75),0.01)

    doTweenY('phantomymove2','bfPhantom2',bfphantomy-6.25*math.sin((songPos/1500) * (bpm/30) *0.75),0.01)
    doTweenX('phantomxmove2','bfPhantom2',bfphantomx-12.5*math.sin((songPos/1500) * (bpm/15) *0.75),0.01)

    doTweenY('dphantomymove','dadPhantom',dadphantomy+6.25*math.sin((songPos/1500) * (bpm/15) *0.75),0.01)
    doTweenX('dphantomxmove','dadPhantom',dadphantomx+12.5*math.sin((songPos/1500) * (bpm/30) *0.75),0.01)

    doTweenY('dphantomymove2','dadPhantom2',dadphantomy-6.25*math.sin((songPos/1500) * (bpm/30) *0.75),0.01)
    doTweenX('dphantomxmove2','dadPhantom2',dadphantomx-12.5*math.sin((songPos/1500) * (bpm/15) *0.75),0.01)
    end
end
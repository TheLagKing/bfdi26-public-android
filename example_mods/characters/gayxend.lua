function onCreate()
makeLuaSprite('jail','characters/bfdimemes/gay baby x/gay baby jkail',getProperty('gf.x'),getProperty('gf.y')+175)
setScrollFactor('jail',getProperty('gf.scrollFactor.x'),getProperty('gf.scrollFactor.y'))
addLuaSprite('jail',false)
    setProperty('jail.visible',false)
end

function onEvent(n,v1,v2)
if n == 'Change Character' then
if v1 == 'gf' and v2 == 'gayxend' then
setProperty('jail.visible',true)
end
end
end
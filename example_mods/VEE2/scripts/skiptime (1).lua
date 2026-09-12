
function onUpdate(elapsed)
    if (keyboardJustPressed("THREE")) then
        runHaxeCode([[
            game.setSongTime(Conductor.songPosition + 10000);
            game.clearNotesBefore(Conductor.songPosition);
        ]])
    end
end
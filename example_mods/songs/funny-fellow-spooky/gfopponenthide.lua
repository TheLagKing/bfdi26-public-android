function goodNoteHit(_, noteData, noteType) -- Easier to read than one letters. :innocent:
  bothSing(noteData, noteType)
end

function opponentNoteHit(_, noteData, noteType)
  bothSing(noteData, noteType)
end

function bothSing(noteData, noteType, miss)
  if noteType ~= "Duet Note" then return end
  playAnim("gf", getProperty("singAnimations["..noteData.."]") .. (miss and "-miss" or ""), true)
  setProperty("gf.holdTimer", 0)
end
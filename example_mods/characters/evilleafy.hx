function opponentNoteHit(note){
    if(game.health >= 0.4)
        game.health -= note.hitHealth;
}
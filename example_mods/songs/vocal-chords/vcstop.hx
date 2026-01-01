function onCountdownStarted() 
{
    Conductor.songPosition = Conductor.crochet * -3;
    game.skipCountdown = false;
}

function onCreatePost() if (game.startedCountdown) game.startTimer.cancel();
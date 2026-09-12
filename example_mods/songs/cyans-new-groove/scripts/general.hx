function onSongStart() 
{
FlxG.drawFramerate = 24;
FlxG.updateFramerate = 24;
}

function onEndSong() 
{
FlxG.drawFramerate = ClientPrefs.data.framerate;
FlxG.updateFramerate = ClientPrefs.data.framerate;

Highscore.saveSongData('cyans-new-groove',1,game.songScore,game.percent,Highscore.calculateFC(game.songMisses,game.percent),game.ratingsData[0].hits,game.ratingsData[1].hits,game.ratingsData[2].hits,game.ratingsData[3].hits);
ModSave.markSongSeen('cyans-new-groove');

FlxG.switchState(()-> new funkin.states.FreeplayState());

FlxG.sound.music.pause();
FlxG.sound.music.stop();
FlxG.sound.playMusic(Paths.music('freeplayMenu'), 0);
return Function_Stop;
}

function onDestroy()
{
FlxG.drawFramerate = ClientPrefs.data.framerate;
FlxG.updateFramerate = ClientPrefs.data.framerate;
}
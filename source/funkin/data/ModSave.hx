package funkin.data;

class ModSave 
{
    //updated songs ----------------------
    public static final updatedSongs:Array<String> = [ // put every updated song whenever u release a new update ok? set it and then do FlxG.save.data.flush()
        'invitational', 'oneshot', 'web-crasher',
        'hey-two', 'evil-song', 'funny-fellow',
        'bossy', 'time', 'whos-there',
        'syskill', 'vocal-chords',
		'yoylefake'
    ];
    public static var playedUpdatedSongs:Array<String> = [];

    public static function load():Void {
        playedUpdatedSongs = FlxG.save.data.playedUpdatedSongs != null ? FlxG.save.data.playedUpdatedSongs : [];
    }

    public static function save():Void {
        FlxG.save.data.playedUpdatedSongs = playedUpdatedSongs;
        FlxG.save.flush();
    }

    public static function hasSeenSong(song:String):Bool {
        song = song.toLowerCase();
        if (!updatedSongs.contains(song)) return true;
        return playedUpdatedSongs.contains(song);
    }

    public static function markSongSeen(song:String):Void {
        if (!hasSeenSong(song)) {
            playedUpdatedSongs.push(song.toLowerCase());
            save();
        }
    }

    //secret songs ----------------------
    public static var secretSongs:Map<String, Bool> = ["oneshot" => true, "web-crasher" => true]; //every secret song in the mod. true means they're hidden, false means they're not (turns false when the song is played once)

    public static function initSecretSave()
	{
		if (FlxG.save.data.secretSongs != null)
		{
			var loadedSongs:Map<String, Bool> = FlxG.save.data.secretSongs;
			for (n => v in loadedSongs)
			{
				if (secretSongs.exists(n)) secretSongs.set(n, v);
			}
		}
	}
	
	public static function editSecretSave(song:String, ?bool:Bool = false)
	{
		if (secretSongs.exists(song))
		{
			secretSongs.set(song, bool);
			FlxG.save.data.secretSongs = secretSongs;
			FlxG.save.flush();
		}
	}

    //songs with playable mixes (copy and pasted from secret songs)
    public static var playableMixes:Map<String, Bool> = 
	[
		"oneshot-pico" => false, 
		"blue-golfball-bf" => false, 
		"hey-two-gf" => false, 
		"invitational-dearest" => false, 
		"funny-fellow-spooky" => false, 
		"syskill-pico" => false, 
		"evil-song-pico" => false, 
		"web-crasher-gf" => false, 
		"bossy-lunch" => false
	]; //false mean charatcer mix hasnt been unlocked yet

    public static function initPlayableSave()
	{
		if (FlxG.save.data.playableMixes != null)
		{
			var loadedSongs:Map<String, Bool> = FlxG.save.data.playableMixes;
			for (n => v in loadedSongs)
			{
				if (playableMixes.exists(n)) playableMixes.set(n, v);
			}
		}
	}
	
	public static function editPlayableSave(song:String, ?bool:Bool = true)
	{
		if (playableMixes.exists(song))
		{
			playableMixes.set(song, bool);
			FlxG.save.data.playableMixes = playableMixes;
			FlxG.save.flush();
		}
	}

	public static function loadModSave() 
	{
		load();
		initSecretSave();
		initPlayableSave();
		funkin.data.Highscore.load();
	}
}

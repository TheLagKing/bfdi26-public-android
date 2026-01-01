package funkin.states;

import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxGradient;
import flixel.addons.transition.FlxTransitionableState;

class CrashHandlerState extends MusicBeatState
{
    var errorMsg:String = "";

    public function new(errorMsg:String)
    {
        super();
        this.errorMsg = errorMsg;
    }

    override function create()
    {
        super.create();

        FlxTransitionableState.skipNextTransIn = FlxTransitionableState.skipNextTransOut = true;
        FlxG.camera.antialiasing = ClientPrefs.data.antialiasing;

        var bg = new FlxSprite().loadImage('menus/crash');
        bg.screenCenter();
        bg.setGraphicSize(FlxG.width);
        add(bg);

        var black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        black.screenCenter();
        black.alpha = 0.8;
        add(black);

        var titleTxt = new FlxText(0, 16, 0, "The game has crashed! Please report your bug in the BFDI26 community server.");
        titleTxt.setFormat(Paths.font("flashing.ttf"), 30, 0xFFFFFFFF, CENTER);
        titleTxt.screenCenter(X);
        add(titleTxt);

        var errorTxt = new FlxText(24,titleTxt.y + titleTxt.height + 10, FlxG.width - 24, errorMsg);
        errorTxt.setFormat(Paths.font("flashing.ttf"), 20, 0xFFFFFFFF, LEFT);
        add(errorTxt);

        var infoTxt = new FlxText(24, 0, 
            'Press ESCAPE to return to title screen\n
            Press ENTER to be redirected to the BFDI26 community server (bug reports channel)');
        infoTxt.setFormat(Paths.font("flashing.ttf"), 24, 0xFFFFFFFF, RIGHT);
        infoTxt.x = FlxG.width - infoTxt.width - 16;
        infoTxt.y = FlxG.height- infoTxt.height - 16;
        add(infoTxt);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
        if (FlxG.keys.justPressed.ANY)
        {
            if (FlxG.keys.justPressed.ESCAPE)
            {
                FlxG.switchState(funkin.states.Title.new);
            }

            if (FlxG.keys.justPressed.ENTER)
            {
                CoolUtil.browserLoad('https://discord.gg/jr4wnT6zgh'); //invite to the server that takes you directly to the bugs report channel
            }
        }
    }
}
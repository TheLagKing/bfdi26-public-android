package funkin.api;

import funkin.api.Windows;
import flixel.util.FlxColor;

#if windows
@:buildXml('
<target id="haxe">
	<lib name="wininet.lib" if="windows" />
	<lib name="dwmapi.lib" if="windows" />
</target>
')
@:cppFileCode('
#include <windows.h>
#include <winuser.h>
#pragma comment(lib, "Shell32.lib")
extern "C" HRESULT WINAPI SetCurrentProcessExplicitAppUserModelID(PCWSTR AppID);
')
#end

class NativeAPI
{		
	@:dox(hide) public static function registerAudio() {
		#if windows
		Windows.registerAudio();
		#end
	}

	@:dox(hide) public static function registerAsDPICompatible() {
		#if windows
		Windows.registerAsDPICompatible();
		#end
	}

	public static function setDarkMode(?title:String, enable:Bool)
	{
		#if (windows && cpp)
		if (title == null) title = lime.app.Application.current.window.title;
		Windows.setDarkMode(title, enable);
		redrawWindowHeader();
		#end
	}
	
	public static function redrawWindowHeader()
	{
		#if windows
		flixel.FlxG.stage.window.borderless = true;
		flixel.FlxG.stage.window.borderless = false;
		#end
	}
	
	public static function hasVersion(vers:String) return lime.system.System.platformLabel.toLowerCase().indexOf(vers.toLowerCase()) != -1;
}
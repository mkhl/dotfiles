#!/usr/bin/osascript

-- Script to turn on Cocoa debugging options for a the active executable of an XCode project. See <Foundation/NSDebug.h>

on createvariable(inName, inValue)
	tell application "Xcode"
		set theExecutable to active executable of project of active project document
		if (every environment variable of theExecutable where name is inName) is {} then
			make new environment variable at end of theExecutable with properties {name:inName, value:inValue, active:true}
		end if
	end tell
end createvariable

try
	createvariable("NSDebug", "YES")
	createvariable("NSZombieEnabled", "YES")
	createvariable("NSZombieEnabled", "YES")
	createvariable("NSDeallocateZombies", "NO")
	createvariable("NSHangOnUncaughtException", "NO")
	createvariable("NSEnableAutoreleasePool", "YES")
	createvariable("NSAutoreleaseFreedObjectCheckEnabled", "NO")
	createvariable("NSAutoreleaseHighWaterMark", "0")
	createvariable("NSAutoreleaseHighWaterResolution", "0")
on error error_message
	display dialog error_message ¬
		with icon 2 ¬
		buttons {"OK"} default button 1
end try

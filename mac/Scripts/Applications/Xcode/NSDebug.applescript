-- Script to turn on Cocoa debugging options for a the active executable of an XCode project. See <Foundation/NSDebug.h>
-- For extra points change "project document 1" to whatever the right specifier for front most project document.

on createvariable(inName, inValue)
	tell application "Xcode"
		set theExecutable to active executable of project document 1 of application "Xcode"
		if (every environment variable of theExecutable where name is inName) is {} then
			make new environment variable at end of theExecutable with properties {name:inName, value:inValue, active:true}
		end if
	end tell
end createvariable

createvariable("NSDebug", "YES")
createvariable("NSZombieEnabled", "YES")
createvariable("NSZombieEnabled", "YES")
createvariable("NSDeallocateZombies", "NO")
createvariable("NSHangOnUncaughtException", "NO")
createvariable("NSEnableAutoreleasePool", "YES")
createvariable("NSAutoreleaseFreedObjectCheckEnabled", "NO")
createvariable("NSAutoreleaseHighWaterMark", "0")
createvariable("NSAutoreleaseHighWaterResolution", "0")


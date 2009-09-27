#!/usr/bin/osascript

tell application "Interface Builder"
	set _doc to front document
	set _name to name of _doc
	set _window to first window of _doc whose name is _name
	if _window exists then
		set bounds of _window to {288, 0, 1141, 300}
	end if
end tell

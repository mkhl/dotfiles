#!/usr/bin/osascript

tell application "Interface Builder"
	set _window to first window of front document
	set _name to name of _window
	set _extension to "." & the last item of the words of _name
	if _name ends with _extension then
		set bounds of _window to {288, 0, 1141, 300}
	end if
end tell

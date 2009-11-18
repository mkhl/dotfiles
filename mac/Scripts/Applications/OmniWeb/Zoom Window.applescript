#!/usr/bin/osascript

tell application "Finder"
	set _bounds to the bounds of the window of the desktop
	set screenHeight to item 4 of _bounds
end tell
set screenWidth to screenHeight / 10 * 16
set menubarHeight to 22
set windowWidth to 1072
set padding to 5
set windowBounds to { padding, menubarHeight + padding, windowWidth + padding, screenHeight - padding }

tell application "OmniWeb"
	set _window to first window where titled is true
	set the bounds of the _window to windowBounds
end tell

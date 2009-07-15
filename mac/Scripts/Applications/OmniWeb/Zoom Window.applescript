#!/usr/bin/osascript

tell application "Finder"
	set _bounds to the bounds of the window of the desktop
	set screenHeight to item 4 of _bounds
end tell
set screenWidth to screenHeight / 10 * 16
set menubarHeight to 22
set windowWidth to 1024
set windowBounds to {5, menubarHeight + 5, windowWidth, screenHeight - 5}

tell application "OmniWeb"
	set the bounds of the front window to windowBounds
end tell

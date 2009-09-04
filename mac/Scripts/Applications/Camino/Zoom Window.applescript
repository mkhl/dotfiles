#!/usr/bin/osascript

tell application "Finder"
	set _bounds to the bounds of the window of the desktop
	set screenHeight to item 4 of _bounds
end tell
set screenWidth to screenHeight / 10 * 16
set menubarHeight to 22
set windowWidth to 1024
set windowBounds to {4, menubarHeight + 4, windowWidth + 4, screenHeight - 4}

tell application "Camino"
	set the bounds of the front window to windowBounds
end tell

#!/usr/bin/osascript

tell application "Finder"
	set _bounds to the bounds of the window of the desktop
	set screenHeight to item 4 of _bounds
end tell
set screenWidth to screenHeight / 10 * 16
set menubarHeight to 22
set windowWidth to 1072
set padding to 22
set windowBounds to {(3.5 * padding), menubarHeight + (0.5 * padding), windowWidth + (3 * padding), screenHeight - (3 * padding)}

tell application "Google Chrome"
	set _window to first window where titled is true
	set the bounds of the _window to windowBounds
end tell

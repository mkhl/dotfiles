#!/usr/bin/osascript

set windowBounds to {32, 56, 1056, 872}

tell application "NetNewsWire"
	set the bounds of the front window to windowBounds
end tell

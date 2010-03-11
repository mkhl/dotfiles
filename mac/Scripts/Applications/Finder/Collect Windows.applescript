#!/usr/bin/osascript

set window_size to {333, 155, 1103, 575}

tell application "Finder"
	set bounds of (every window where titled is true and class is Finder window) to window_size
end tell

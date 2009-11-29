#!/usr/bin/osascript

set small_size to {310, 138, 1051, 574}
set large_size to {430, 168, 1171, 604}

tell application "Finder"
	set bounds of (every window where titled is true) to large_size
end tell

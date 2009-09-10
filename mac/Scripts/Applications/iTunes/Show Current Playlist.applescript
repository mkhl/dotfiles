#!/usr/bin/osascript

tell application "iTunes"
	if player state is playing then
		set view of (front browser window) ¬
			to playlist (name of current playlist)
	end if
end tell
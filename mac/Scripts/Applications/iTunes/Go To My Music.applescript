#!/usr/bin/osascript

-- Source: http://www.red-sweater.com/blog/930/go-to-my-music

tell application "iTunes"
	set view of (front browser window) to first user playlist
end tell

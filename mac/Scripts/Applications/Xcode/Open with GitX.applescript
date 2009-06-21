#!/usr/bin/osascript

-- Opens the current Xcode project in GitX.
-- By Martin Kühl <http://purl.org/net/mkhl>

on run
	tell application "Xcode"
		try
			set _path to path of active project document
			set _file to POSIX file _path as alias
			my gitx(_file)
		on error
			-- don't do anything
		end try
	end tell
end run

on gitx(_items)
	tell application "GitX"
		open _items
		activate
	end tell
end gitx

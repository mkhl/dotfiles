#!/usr/bin/osascript

-- Opens the current Xcode project in GitX.
-- By Martin Kühl <http://purl.org/net/mkhl>

on run
	tell application "Xcode"
		try
			set _path to path of active project document
			do shell script ¬
				"cd \"$(dirname " & quoted form of _path & ")\" && gitx"
		on error
			-- don't do anything
		end try
	end tell
end run

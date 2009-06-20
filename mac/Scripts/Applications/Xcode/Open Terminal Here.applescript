#!/usr/bin/osascript

-- Opens the current Xcode project folder in Terminal.
-- By Martin Kühl <http://purl.org/net/mkhl>

on run
	tell application "Xcode"
		try
			set _path to path of active project document
			set _script to "cd \"$(dirname " ¬
				& quoted form of _path ¬
				& ")\" && echo -ne '\\ec'"
			tell application "Terminal"
				if running then
					do script _script
				else
					launch
					do script _script in (selected tab of front window)
				end if
			end tell
		on error
			-- don't do anything
		end try
	end tell
end run

#!/usr/bin/osascript

-- Opens the current Xcode project in GitX.
-- By Martin Kühl <http://purl.org/net/mkhl>

on run
	try
		set _path to xcode_project_path()
		set _file to POSIX file _path as alias
		gitx(_file)
	on error error_message
		tell application "System Events"
			display dialog error_message ¬
				with icon 2 ¬
				buttons {"OK"} default button 1
		end tell
	end try
end run

on xcode_project_path()
	tell application "Xcode"
		return path of active project document
	end tell
end xcode_project_path

on gitx(_items)
	tell application "GitX"
		open _items
		activate
	end tell
end gitx

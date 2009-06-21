#!/usr/bin/osascript

-- Opens the current Xcode project folder in Terminal.
-- By Martin Kühl <http://purl.org/net/mkhl>

on run
	try
		set _path to xcode_project_path()
		set _file to POSIX file _path as alias
		terminal(_file)
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

on terminal(_file)
	set _folder to parent_folder(_file)
	set _script to "cd " ¬
		& (quoted form of POSIX path of _folder) ¬
		& "; echo -ne '\\ec'"
	tell application "Terminal"
		if running then
			do script _script
		else
			launch
			do script _script in (selected tab of front window)
		end if
	end tell
end terminal

on parent_folder(_file)
	tell application "Finder"
		get container of (item _file) as alias
	end tell
end parent_folder

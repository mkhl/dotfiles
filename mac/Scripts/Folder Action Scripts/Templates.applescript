#!/usr/bin/osascript

on removing folder items from this_folder
	tell application "Finder"
		set source_ to folder "Templates" of folder "New Files" ¬
			of (path to the library folder from the user domain)
		set target_ to this_folder
		set items_ to the files of source_
		repeat with file_ in items_
			set name_ to name of file_
			if not (exists name_ in target_) then
				copy file_ to folder target_
			end if
		end repeat
	end tell
end removing folder items from

#!/usr/bin/osascript

on removing folder items from this_folder
	tell application "Finder"
		set source_ to folder "Templates" of parent of this_folder
	end tell
	rebuild(source_, this_folder)
end removing

on rebuild(source_, target_)
	tell application "Finder"
		set items_ to files of source_
		repeat with file_ in items_
			set name_ to name of file_
			if not (exists name_ in target_) then
				copy file_ to folder target_
			end if
		end repeat
	end tell
end rebuild

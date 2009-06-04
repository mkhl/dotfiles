#!/usr/bin/osascript

on removing folder items from this_folder
	tell application "Finder"
		set source_ to folder "Templates" of parent of this_folder
	end tell
	rebuild(source_, this_folder)
end removing folder items from

on rebuild(source_, target_)
	tell application "Finder"
		set items_ to files of source_
		repeat with file_ in items_
			set name_ to name of file_
			if not exists (file name_ of target_) then
				duplicate file_ to target_
			end if
		end repeat
	end tell
end rebuild

on run
	tell application "Finder"
		set base_ to folder "Templates" of (path to library folder from user domain)
		set source_ to folder "Templates" of base_
		set target_ to folder "New File" of base_
	end tell
	rebuild(source_, target_)
end run

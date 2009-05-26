-- Moves the currently slected Finder items to a New Folder.
-- The folder is created in the folder of the front window (or the Desktop).
on run
	tell application "Finder"
		set items_ to selection
	end tell
	groupFiles(items_)
end run

on open(items_)
	groupFiles(items_)
end open

on groupFiles(items_)
	tell application "Finder"
		if items_ is not {} then
			try
				set target_folder_ to folder of front window
			on error
				set target_folder_ to desktop
			end try
			set new_folder_ to (make new folder in target_folder_)
			move items_ to new_folder_
			-- Now select the folder and let us change its name.
			activate
			select new_folder_
			tell app "System Events"
				keystroke return
			end tell
		end if
	end tell
end groupFiles

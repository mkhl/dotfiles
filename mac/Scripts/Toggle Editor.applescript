set the_editor to "Emacs"

if running of application the_editor then
	if frontmost of application the_editor then
		tell application "System Events"
			tell application process the_editor
				set visible to false
			end tell
		end tell
	else
		tell application the_editor
			activate
		end tell
	end if
else
	tell application the_editor
		launch
		activate
	end tell
end if

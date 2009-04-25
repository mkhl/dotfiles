set the_terminal to "Terminal"

if running of application the_terminal then
	if frontmost of application the_terminal then
		tell application "System Events"
			tell application process the_terminal
				set visible to false
			end tell
		end tell
	else
		tell application the_terminal
			activate
		end tell
	end if
else
	tell application the_terminal
		launch
		activate
	end tell
end if

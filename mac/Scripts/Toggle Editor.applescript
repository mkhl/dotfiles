set _appname to "Emacs"

if frontmost of application _appname then
	tell application "System Events"
		tell application process _appname
			set visible to false
		end tell
	end tell
else
	tell application _appname
		activate
	end tell
end if


-- Based on: http://mublag.boinkor.net/post/21305127/Safari-Search-APPLESCRIPT-460-Bytes

tell application "Safari"
	activate
	if exists front document then
		if (URL of front document) does not start with "topsites:" then
			tell front window to set current tab to (make new tab)
		end if
	else
		make new document
	end if
	tell application "System Events"
		keystroke "f" using {command down, option down}
	end tell
end tell

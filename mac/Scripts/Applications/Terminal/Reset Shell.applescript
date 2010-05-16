#!/usr/bin/osascript

tell application "Terminal"
	repeat with _tab in tabs of front window
		do script "restart_shell" in _tab
	end repeat
end tell

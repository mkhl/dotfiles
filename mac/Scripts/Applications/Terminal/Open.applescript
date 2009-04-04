tell application "Terminal"
	try
		do script "open \"$PWD\"" in window 1
	on error
		do script "open \"$PWD\""
	end try
end tell

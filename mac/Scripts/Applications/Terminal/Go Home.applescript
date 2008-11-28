tell application "Terminal"
	try
		do script "cd ~/" in window 1
	on error
		do script "cd ~/"
	end try
end tell

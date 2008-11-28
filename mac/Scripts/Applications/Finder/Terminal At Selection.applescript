-- © Copyright 2005, Red Sweater Software. All Rights Reserved.
-- Permission to copy granted for personal use only. All copies of this script
-- must retain this copyright information and all lines of comments below, up to
-- and including the line indicating "End of Red Sweater Comments". 
--
-- Any commercial distribution of this code must be licensed from the Copyright
-- owner, Red Sweater Software.
--
-- This script facilitates the easy opening of a Terminal window prepared to 
-- perform command-line operations at the directory currently selected or navigated
-- to in the Finder.
--
-- Version 1.1.1 
--		- Disable iTerm support until I can get it to load on machines without iTerm installed.
--
-- Version 1.1
--		- Be sure to use the quoted form of the target folder in case there are funky chars in it.
--		- Updated with modifications by Jan Lehnardt <jan@prima.de> to support iTerm.
--			 iTerm can be found on http://iterm.sf.net/
--
-- Version 1.0 - worked with Terminal application only.
--
-- End of Red Sweater Comments

-- Advice from Jan:
-- To customise this script change the value of terminalApplication to
-- either "Terminal", to use this script with the default Terminal.app that ships with OS X
-- or to "iTerm", to use this script with the iTerm.app from http://iTerm.sf.net/
--    If you use iTerm, you can set the iTermSessionName to the session of your preference

set terminalApplication to "Terminal"
set iTermSessionName to "Default"

set targetFolder to ""

tell application "Finder"
	set mySelection to (selection as list)
	
	-- If there is a single item selected, assume the user wants something close to that
	if ((count of mySelection) is 1) then
		set targetCandidate to first item of mySelection
		
		-- If the user has selected a folder or disk icon, then make that the target folder
		if (class of targetCandidate) is disk or (class of targetCandidate) is folder then
			set targetFolder to POSIX path of (targetCandidate as alias)
		else
			-- Special case Network, since POSIX path doesn't work as expected with it
			if (URL of targetCandidate is equal to "file://localhost/Network") then
				set targetFolder to POSIX path of alias "Network:"
			else
				-- If the user has selected anything else, then make the containing folder the selection
				set targetFolder to POSIX path of (targetCandidate's folder as alias)
			end if
		end if
		
	end if
	
	-- Otherwise, resort to the folder corresponding to the front-most window
	if (targetFolder is equal to "") then
		try
			set targetFolder to POSIX path of (window 1's folder as alias)
		on error
			set targetFolder to ""
		end try
	end if
	
	-- If we still have nothing, assume the Desktop
	if (targetFolder is equal to "") then
		set targetFolder to POSIX path of (path to desktop folder as alias)
	end if
end tell

-- Finally, open a terminal with this path
try
	-- Go with the default Terminal.app
	if (terminalApplication is equal to "Terminal") then
		tell application "Terminal"
			activate
			do script "cd " & quoted form of targetFolder
		end tell
		
		(* Until I can figure out how to make this open nicely on machines without iTerm installed
	I am just going to disable the iTerm support. Users who want to enable it can uncomment this block
			
		-- Wooho, we've got iTerm and we want iIerm
	else if (terminalApplication is equal to "iTerm") then
		tell application "iTerm"
			activate
			-- See, if there is an open iTerm window...
			try
				set myterm to the first terminal
			on error
				-- ...There's not, we open one	
				set myterm to (make new terminal)
			end try
			
			tell myterm
				-- Open a new Default session in a new tab
				launch session iTermSessionName
				tell the last session
					write text "cd " & quoted form of targetFolder
				end tell
				
			end tell
			
		end tell
*)
	else
		display dialog "The selected Terminal program isn't yet supported."
	end if
on error
	display dialog "Sorry, I couldn't do it."
end try
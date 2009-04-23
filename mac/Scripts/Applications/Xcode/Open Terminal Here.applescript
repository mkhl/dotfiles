#!/usr/bin/osascript

(*

    Open Terminal Here
    
    A toolbar script for Mac OS X
    
    Written by Marc Liyanage
    Adapted to Xcode by Martin Kühl
    
    
    See http://www.apple.com/applescript/macosx/toolbar_scripts/ for
    more information about toolbar scripts.
    
    See http://www.entropy.ch/software/applescript/ for the latest
    version of this script.
    
    
    History:
    
    30-OCT-2001: Version 1.0, adapted from one of the example toolbar scripts
    30-OCT-2001: Now handles embedded single quote characters in file names
    30-OCT-2001: Now handles folders on volumes other than the startup volume
    30-OCT-2001: Now handles click on icon in top-level (machine) window
    31-OCT-2001: Now displays a nicer terminal window title, courtesy of Alain Content
    11-NOV-2001: Now folders within application packages (.app directories) and has a new icon
    12-NOV-2001: New properties to set terminal columns and rows as the Terminal does not use default settings
    14-NOV-2001: Major change, now handles 8-bit characters in all shells, and quotes and spaces in tcsh
    18-NOV-2001: Version 1.1: Rewrite, now uses a temporary file  ~/.OpenTerminalHere to communicate
                 the directory name between AppleScript and the shell because this is much more reliable for 8-bit characters
    16-JAN-2006: Version 2.0: Rewrite, now uses "quoted form of" and "POSIX Path". This gets rid of
                 Perl and temp files, but it no longer handles files instead of folders.
    24-JAN-2007: Version 2.1: Integrated enhancements by Stephan Hradek, can again handle dropped files.
    06-AUG-2008: Version 2.2: Added terminal control sequence to clear the visible cd command.
    26-OCT-2008: Version 2.3: Incorporated changes from Florian ?, handling case where Terminal was not already running
*)

-- when the toolbar script icon is clicked
--
on run
    tell application "Xcode"
        activate
        
        try
            set this_folder to (the path of the first project document)
        on error
            set this_folder to (the path to the application "Xcode")
        end try
        
    end tell
    
    if exists this_folder then
        process_item(this_folder)
    end if
    
end run

-- This handler processes folders dropped onto the toolbar script icon
--
on open these_items
    repeat with this_item in these_items
        my process_item(this_item)
    end repeat
end open

-- this subroutine does the actual work
--
on process_item(this_item)
    set the_path to POSIX path of this_item
    repeat until the_path ends with "/"
        set the_path to text 1 thru -2 of the_path
    end repeat
    
    -- set cmd to "cd " & quoted form of the_path & " && echo $'\\ec'"
    set cmd to "cd " & quoted form of the_path
    
    tell application "System Events" to set terminalIsRunning to exists application process "Terminal"
    
    tell application "Terminal"
        activate
        if terminalIsRunning is true then
            do script with command cmd
        else
            do script with command cmd in window 1
        end if
    end tell
    
end process_item

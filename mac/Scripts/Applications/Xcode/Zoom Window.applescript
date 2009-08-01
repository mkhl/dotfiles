#!/usr/bin/osascript

(* Zoom Window

Zoom the current Xcode window to a comfortable width and the full screen
height. Use a different width for editor windows and project windows.

In my multi-monitor setup, the screens are always horizontally adjacent,
the main display is on the largest screen, and Xcode is always on the main
display, and all of my monitors are 16x10. That's why I can figure out the
screen size programmatically.

See [1] for a discussion of problems with getting the screen dimensions in
a multi-monitor setup.

[1]: http://daringfireball.net/2006/12/display_size_applescript_the_lazy_way
*)

tell application "Finder"
	set _bounds to the bounds of the window of the desktop
	set screenHeight to item 4 of _bounds
end tell
set screenWidth to screenHeight / 10 * 16
set menubarHeight to 22

set projectWindowWidth to 907
set projectWindowHeight to screenHeight - menubarHeight
set projectWindowSize to {projectWindowWidth, projectWindowHeight}

set editorWindowWidth to 625
set editorWindowHeight to screenHeight - menubarHeight - 10
set editorWindowBounds to {15, 5, 15 + editorWindowWidth, 5 + editorWindowHeight}

tell application "Xcode"
	set _name to name of front window
	set _extension to "." & last item of words of _name
	if _name ends with _extension then
		set _bounds to bounds of front window
		set item 1 of editorWindowBounds to item 1 of _bounds
		set item 3 of editorWindowBounds to item 1 of _bounds + editorWindowWidth
		set bounds of front window to editorWindowBounds
	else
		set size of front window to projectWindowSize
	end if
end tell

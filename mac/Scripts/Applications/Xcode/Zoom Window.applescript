#!/usr/bin/osascript

-- Zoom Window

-- Zoom the current Xcode window to a comfortable width and the complete screen
-- height. I usually run Xcode on the main display, so I have hard-coded its size
-- here.
-- See http://daringfireball.net/2006/12/display_size_applescript_the_lazy_way
-- for a discussion of problems with getting the screen dimensions in a
-- multi-monitor setup.

set screenWidth to 1440
set screenHeight to 900
set menubarHeight to 22

set projectWindowWidth to 907
set projectWindowHeight to screenHeight - menubarHeight

tell application "Xcode"
	set the size of the front window to {projectWindowWidth, projectWindowHeight}
end tell

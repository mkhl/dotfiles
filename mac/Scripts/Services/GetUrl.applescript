#!/usr/bin/osascript

on GetCurrentApp()
	tell application "System Events"
		set _app to item 1 of (every process whose frontmost is true)
		return name of _app
	end tell
end GetCurrentApp

on GetDefaultWebBrowser()
	set _scpt to "perl -MMac::InternetConfig -le " & ¬
		"'print +(GetICHelper \"http\")[1]'"
	return do shell script _scpt
end GetDefaultWebBrowser

on process()
	set _browser to GetCurrentApp()
	if _browser is not "Safari" or "WebKit" then
		set _browser to GetDefaultWebBrowser()
	end if
	if _browser is "Safari" or "WebKit" then
		using terms from application "Safari"
			tell application _browser
				return URL of the front document
			end tell
		end using terms from
	else if _browser is "Camino" then
		using terms from application "Camino"
			tell application _browser
				return URL of the current tab of the front window
			end tell
		end using terms from
	else if _browser is "Firefox" or "Shiretoko" then
		using terms from application "Firefox"
			tell application _browser
				return «class curl» of the front window
			end tell
		end using terms from
	end if
end process

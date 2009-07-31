
set _browser to GetCurrentApp()
if _browser is not "Safari" or "WebKit" then
    set _browser to GetDefaultWebBrowser()
end if
using terms from application "Safari"
    tell application _browser
        -- do stuff with Safari or WebKit here
    end tell
end using terms from


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

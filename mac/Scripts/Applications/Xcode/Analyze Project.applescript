#!/usr/bin/osascript

-- Analyze Project

-- Analyze the current Xcode project with AnalysisTool.
-- Relies on UI Scripting to access AnalysisTool. You have been warned.

try
	set _project to xcode_project_path()
	analyze(_project)
on error error_message
	display dialog error_message ¬
		with icon 2 ¬
		buttons {"OK"} default button 1
end try

on xcode_project_path()
	tell application "Xcode"
		return path of project of active project document
	end tell
end xcode_project_path

on analyze(this_file)
	try
		tell application "AnalysisTool"
			launch
			activate
			tell application "System Events"
				tell application process "AnalysisTool"
					tell window 1
						tell text field 1
							set value of attribute "AXValue" to this_file
							keystroke " "
							key code 51
							perform action "AXConfirm"
						end tell
						tell button "Run analyses"
							click
						end tell
					end tell
				end tell
			end tell
		end tell
	on error error_message
		display dialog error_message ¬
			with icon 2 ¬
			buttons {"OK"} default button 1
	end try
end analyze

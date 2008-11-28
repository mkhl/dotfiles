(*
"Unquarantine" by Henrik Nyh <http://henrik.nyh.se/2007/10/lift-the-leopard-download-quarantine>
This Folder Action handler is triggered whenever items are added to the attached folder.
It gets rid of Leopard's annoying "this application was downloaded from the Internet" warnings by stripping the "quarantine" property.
*)

on adding folder items to thisFolder after receiving addedItems
	
	repeat with anItem in addedItems
		set anItem's contents to (quoted form of POSIX path of (anItem as alias))
	end repeat
	
	set AppleScript's text item delimiters to " "
	do shell script "xattr -d com.apple.quarantine " & (addedItems as text)
	
end adding folder items to

#!/usr/bin/osascript

on process(_input)
	repeat with _item in every paragraph of _input
		open location _item
	end repeat
end process

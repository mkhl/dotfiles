-- Opens the currently selected Finder files, or else the current Finder window, in GitX. Also handles dropped files and folders.
-- By Henrik Nyh <http://henrik.nyh.se>
-- Based loosely on http://snippets.dzone.com/posts/show/1037
-- Modified by Martin Kuehl <http://purl.org/net/mkhl>

-- script was clicked
on run
    tell application "Finder"
        try
            if selection is {} then
                set finderSelection to folder of the front window as string
            else
                set finderSelection to selection as alias list
            end if
        on error
           set finderSelection to home as string
        end try
    end tell

    gitx(finderSelection)
end run

-- script was drag-and-dropped onto
on open(theList)
    gitx(theList)
end open

-- open with GitX
on gitx(listOfAliases)
    tell application "GitX"
        open listOfAliases
        activate
    end tell
end gitx


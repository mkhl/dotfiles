-- Opens the currently selected Finder files, or else the current Finder window, in Emacs. Also handles dropped files and folders.
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

    emacs(finderSelection)
end run

-- script was drag-and-dropped onto
on open(theList)
    emacs(theList)
end open

-- open in Emacs
on emacs(listOfAliases)
    tell application "Emacs"
        open listOfAliases
        activate
    end tell
end emacs


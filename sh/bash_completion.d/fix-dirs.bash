# Fix completion of dirs with spaces.
compopt -o default $(complete -p| grep -e '-o filenames'| grep -v -e '-o default'| sed -E -e 's/.+\s+//')

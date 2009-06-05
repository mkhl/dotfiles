# Fix completion of dirs with spaces.
if (( ${BASH_VERSINFO[0]} >= 4 )); then
	compopt -o default $(complete -p| grep -e '-o filenames'| grep -v -e '-o default'| sed -E -e 's/.+\s+//')
	compopt -o default cd
fi

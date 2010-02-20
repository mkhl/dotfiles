# In Bash v4, `-o filenames' breaks for paths with spaces.
# Completing with `-o default' works around this problem.
if (( ${BASH_VERSINFO[0]} >= 4 )); then
    compopt -o default bash             \
        $(complete -p                   \
        | grep -e '-o filenames'        \
        | grep -v -e '-o default'       \
        | awk '{ print $NF }')
fi

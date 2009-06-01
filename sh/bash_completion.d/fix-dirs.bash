# Fix completion of dirs with spaces.
# complete -p | grep -e '-o filenames' | grep -v -e '-o default'| while read line; do
# 	eval "${line/-o filenames/-o filenames -o default}"
# done
complete -o nospace -o default -v -F _cd cd

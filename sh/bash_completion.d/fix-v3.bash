# Fix v3 completion for `cd'
complete -o nospace -o dirnames -v -F _cd cd

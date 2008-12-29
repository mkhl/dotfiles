complete -W "$(github help | perl -ne 'print if s/^\s+(\S+)\s+=>.*$/$1/')" \
         -o default \
         -o nospace \
         -F _git \
         github gh

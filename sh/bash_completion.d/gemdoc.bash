#!/bin/bash
__gemdoc () {
    COMPREPLY=( $(compgen -W "$(ls $(gem env gemdir)/doc)" -- ${COMP_WORDS[COMP_CWORD]}) )
    return 0
}
complete -o default -o nospace -F __gemdoc gemdoc

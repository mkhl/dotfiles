#!/bin/bash
__open () {
    COMPREPLY=()
    if [[ "${COMP_WORDS[$COMP_CWORD-1]}" == "-a" ]] ; then
        apps=$(ps ax|egrep -o '[^/]+\.app'|sed 's/\.app$//; s/ /\\\\ /g')
        local IFS=$'\n'
        COMPREPLY=( $(compgen -W "$apps" -- "${COMP_WORDS[COMP_CWORD]}") )
    fi
    return 0
}
complete -o default -F __open open

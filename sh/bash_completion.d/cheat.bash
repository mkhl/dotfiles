#!/bin/bash
__cheat () {
	COMPREPLY=()
	if [[ "$COMP_CWORD" = "1" ]]; then
		sheets="$(cheat sheets | tail -n +2)"
		COMPREPLY=( $(compgen -W "$sheets" -- "$2") )
	fi
}
complete -F __cheat cheat

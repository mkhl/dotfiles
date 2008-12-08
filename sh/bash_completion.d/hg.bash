# Mercurial completion by Alexis S. L. Carvalho <alexis@cecm.usp.br>
#
# See: http://www.selenic.com/pipermail/mercurial/2005-August/003378.html
#
# $Id: hg,v 1.1 2006/02/26 00:25:41 ianmacd Exp $
#
_hg_commands()
{
    local commands="$(hg -v help | sed -e '1,/^list of commands:/d' \
				       -e '/^global options:/Q' \
				       -e '/^ [^ ]/!d; s/[,:]//g;')"
    
    # hide debug commands from users, but complete them if 
    # specifically asked for
    if [[ "$cur" == de* ]]; then
	commands="$commands debugcheckstate debugstate debugindex"
	commands="$commands debugindexdot debugwalk"
    fi
    COMPREPLY=( ${COMPREPLY[@]:-} $(compgen -W "$commands" -- "$cur") )
}

_hg_paths()
{
    local paths="$(hg paths | sed -e 's/ = .*$//')"
    COMPREPLY=(${COMPREPLY[@]:-} $( compgen -W "$paths" -- "$cur" ))
}

_hg_tags()
{
    local tags="$(hg tags | sed -e 's/[0-9]*:[a-f0-9]\{40\}$//; s/ *$//')"
    COMPREPLY=( ${COMPREPLY[@]:-} $(compgen -W "$tags" -- "$cur") )
}

# this is "kind of" ugly...
_hg_count_non_option()
{
    local i count=0
    local filters="$1"

    for (( i=1; $i<=$COMP_CWORD; i++ )); do
	if [[ "${COMP_WORDS[i]}" != -* ]]; then
	    for f in $filters; do
		if [[ ${COMP_WORDS[i-1]} == $f ]]; then
		    continue 2
		fi
	    done
	    count=$(($count + 1))
	fi
    done

    echo $(($count - 1))
}

_hg()
{
    local cur prev cmd opts i

    COMPREPLY=()
    cur="$2"
    prev="$3"

    # searching for the command 
    # (first non-option argument that doesn't follow -R/--repository)
    for (( i=1; $i<=$COMP_CWORD; i++ )); do
	if [[ ${COMP_WORDS[i]} != -* ]] \
	   && [ "${COMP_WORDS[i-1]}" != -R ] \
	   && [ "${COMP_WORDS[i-1]}" != --repository ]; then
	    cmd="${COMP_WORDS[i]}"
	    break
	fi
    done

    if [[ "$cur" == -* ]]; then
	opts="$(hg -v help | sed -e '1,/^global options/d; /^ -/!d')"

	if [ -n "$cmd" ]; then
	    opts="$opts $(hg help "$cmd" | sed -e '/^ -/!d; s/ [^-][^ ]*//')"
	fi

	COMPREPLY=( ${COMPREPLY[@]:-} $(compgen -W "$opts" -- "$cur") )
	return
    fi

    if [ "$prev" = -R ] || [ "$prev" = --repository ]; then
	COMPREPLY=(${COMPREPLY[@]:-} $( compgen -d -- "$cur" ))
	return
    fi

    if [ -z "$cmd" ] || [ $COMP_CWORD -eq $i ]; then
	_hg_commands
	return
    fi

    if [ "$cmd" != status ] && [ "$prev" = -r ] || [ "$prev" = --rev ]; then
	_hg_tags
	return
    fi

    case "$cmd" in
	help)
	    _hg_commands
	;;
	export|manifest|update|checkout|up|co)
	    _hg_tags
	;;
	pull|push)
	    _hg_paths
	    COMPREPLY=(${COMPREPLY[@]:-} $( compgen -d -- "$cur" ))
	;;
	paths)
	    _hg_paths
	;;
	clone)
	    local count=$(_hg_count_non_option)
	    if [ $count = 1 ]; then
		_hg_paths
	    fi
	    COMPREPLY=(${COMPREPLY[@]:-} $( compgen -d -- "$cur" ))
	;;
	cat)
	    local count=$(_hg_count_non_option -o --output)
	    if [ $count = 2 ]; then
		_hg_tags
	    else
		COMPREPLY=(${COMPREPLY[@]:-} $( compgen -f -- "$cur" ))
	    fi
	;;
	*) 
	    COMPREPLY=(${COMPREPLY[@]:-} $( compgen -f -- "$cur" ))
	;;
    esac

}
complete -o filenames -F _hg hg

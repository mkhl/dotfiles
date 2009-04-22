if [[ "$TERM_PROGRAM" == "DTerm" ]]; then
    function sudo () {
        cmd="$1"
        shift
        authexec "$(whereis "$cmd")" "$@"
    }
fi

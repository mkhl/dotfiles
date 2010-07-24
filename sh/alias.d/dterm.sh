if [[ "$TERM_PROGRAM" == "DTerm" ]]; then
	sudo () {
		cmd="$1"; shift
		authexec "$(command which "$cmd")" "$@"
	}
fi

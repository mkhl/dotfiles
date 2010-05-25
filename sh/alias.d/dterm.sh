if [[ "$TERM_PROGRAM" == "DTerm" ]]; then
	function sudo () {
		authexec /usr/bin/sudo "$@"
	}
fi

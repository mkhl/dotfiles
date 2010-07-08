if [[ "$TERM_PROGRAM" == "DTerm" ]]; then
	sudo () {
		authexec /usr/bin/sudo "$@"
	}
fi

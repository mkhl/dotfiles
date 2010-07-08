# Pip completion
_pip_completion() {
	if has_cmd pip; then
		eval "$(pip completion --$is)"
	fi
	_pip_completion "$@"
}
complete -o default -F _pip_completion pip

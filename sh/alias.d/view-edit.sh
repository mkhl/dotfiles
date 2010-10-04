# Viewing/editing files
if has_cmd vim; then
	alias vi='vim'
fi
if has_cmd emacsclient; then
	alias emc='emacsclient --no-wait'
	alias emacsclient='emacsclient --alternate-editor="" -c'
fi
alias e='$EDITOR'
alias p='$PAGER'
alias v='$PAGER'
alias vs='$PAGER -S'
alias o='open'

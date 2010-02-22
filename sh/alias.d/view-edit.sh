# Viewing/editing files
if has_cmd vim; then
    alias vi='vim'
fi
if has_cmd emacsclient; then
    alias emc='emacsclient --no-wait'
fi
alias e='$EDITOR'
alias m='$PAGER'
alias v='$PAGER'
alias vs='$PAGER -S'
alias o='open'

# Default listing
LS_OPTIONS="-q"
GLS_OPTIONS="$LS_OPTIONS -T 0 --color=auto"
case "$(uname)" in
	*BSD|Darwin) LS_OPTIONS="$LS_OPTIONS -G" ;;
	Linux)       LS_OPTIONS="$GLS_OPTIONS" ;;
esac
alias ls='ls $LS_OPTIONS'
alias gls='gls $GLS_OPTIONS'

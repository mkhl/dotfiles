# SBCL w/ readline editing
export LISP_BREAK_CHARS="\"#'(),;\`\\|!?[]{}"       # " # -- fix highlighting
alias rlsbcl="rlwrap -b \$LISP_BREAK_CHARS sbcl"

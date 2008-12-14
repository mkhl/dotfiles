# "Colorized" emacs
if has_emacs ; then
    tset -I -Q
    stty cooked pass8 dec nl -echo
    if [[ "$is" == "zsh" ]]; then
        unsetopt zle
    fi
fi

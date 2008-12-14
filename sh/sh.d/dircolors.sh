# Dircolors
if has_cmd dircolors ; then
    if [[ -f "$HOME/.dir_colors" ]]; then
        eval $(dircolors -b "$HOME/.dir_colors")
    else
        eval $(dircolors -b)
    fi
fi

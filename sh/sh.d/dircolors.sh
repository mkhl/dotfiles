# Dircolors
cmd=$(choose_cmd dircolors gdircolors)
if [[ -n "$cmd" ]]; then
    if [[ -f "$HOME/.dir_colors" ]]; then
        eval $($cmd -b "$HOME/.dir_colors")
    else
        eval $($cmd -b)
    fi
fi
unset -v cmd

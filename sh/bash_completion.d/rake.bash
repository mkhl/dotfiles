# Uncached version:
# complete -W "$(rake -T 2>/dev/null | awk 'NR != 1 {print $2}')" -o default rake
# Cached version:
complete -C $HOME/.bash_completion.d/rake-tasks.rb -o default rake
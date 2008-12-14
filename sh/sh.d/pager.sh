# Pager
if has_cmd lesspipe.sh ; then
    export LESSOPEN="|$(choose_cmd lesspipe.sh) %s"
fi
READNULLCMD="$PAGER"

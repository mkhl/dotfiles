# Default editor

# # TextMate
# export EDITOR="mate_wait"
# export CVSEDITOR="mate_wait"
# export SVN_EDITOR="$CVSEDITOR"
# export GIT_EDITOR="$CVSEDITOR --line 1"
# export FCEDIT="$CVSEDITOR"
# export VISUAL="$EDITOR"
# export TEXEDIT="$CVSEDITOR --line %d '%s'"
# export LESSEDIT="$EDITOR --line %lm %f"

# Emacs
export EDITOR="emacsclient"
export ALTERNATE_EDITOR="mg"
export CVSEDITOR="$EDITOR"
export SVN_EDITOR="$EDITOR +1"
export GIT_EDITOR="$EDITOR +1"
export FCEDIT="$EDITOR"
export VISUAL="$EDITOR"
export TEXEDIT="$EDITOR +%d '%s'"
export LESSEDIT="$EDITOR +%lm %f"

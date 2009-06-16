#
# bash completion support for easy GIT.
#
# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
# Copyright (C) 2008 Elijah Newren <newren gmail com>
# *Heavily* based on git-completion.sh
# Distributed under the GNU General Public License, version 2.0.
#
# *** IMPORTANT USAGE NOTE ***
# If you are using an old copy of git-completion.sh and you try to complete
# eg commands that the old version of git-completion.sh did not support, you
# may get errors like:
#   bash: _git_fetch: command not found
#
# Reasons/rationale:
#   This could be fixed by pulling all of git-completion.sh into this file,
#   but this would be a heavy maintainence burden.  Also, I like common
#   bugs being fixed in one place...  This only affects a few subcommands,
#   so I don't think the trade-off is harsh.  Besides, you can always
#   download a recent copy of git and just install the git-completion.sh
#   file all by itself to fix any such issues.
# *** END USAGE NOTE ***
#
# The contained completion routines provide support for completing:
#
#    *) local and remote branch names
#    *) local and remote tag names
#    *) .git/remotes file names
#    *) git 'subcommands'
#    *) tree paths within 'ref:path/to/file' expressions
#    *) common --long-options
#
# To use these routines (s/git-completion.sh/bash-completion-eg.sh/ in
# instructions below, but make sure git-completion.sh from the 
# contrib/completion/ directory of git sources is also in use):
#
#    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
#    2) Added the following line to your .bashrc:
#        source ~/.git-completion.sh
#
#    3) You may want to make sure the git executable is available
#       in your PATH before this script is sourced, as some caching
#       is performed while the script loads.  If git isn't found
#       at source time then all lookups will be done on demand,
#       which may be slightly slower.
#
#    4) Consider changing your PS1 to also show the current branch:
#        PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#
#       The argument to __git_ps1 will be displayed only if you
#       are currently in a git repository.  The %s token will be
#       the name of the current branch.
#
# *** Maintainence Note ***
# Since this is so heavily based on git-completion.sh, it can be useful
# to run
#   diff -u --ignore-space-change bash-completion-eg.sh git-completion.bash
# against a new version of git-completion.bash (under contrib/completion/
# in a copy of the git sources) in order to pick up any new completion
# commands that should be added to this file.  The main thing to check in
# such a diff are the differences between the _eg() and _git() functions,
# particularly completion support that exists for subcommands in the latter
# but has no corresponding support in the former.
# *** End Note ***

__eg_commands ()
{
  if [ -n "$__eg_commandlist" ]; then
    echo "$__eg_commandlist"
    return
  fi
  local i IFS=" "$'\n'
  eg help --all | egrep "^  eg" | awk '{print $2}' | sort | uniq
}
__eg_commandlist=
__eg_commandlist="$(__eg_commands 2>/dev/null)"

__eg_topics ()
{
  if [ -n "$__eg_topiclist" ]; then
    echo "$__eg_topiclist"
    return
  fi
  local i IFS=" "$'\n'
  eg help topic | egrep "^[A-Za-z]" | awk '{print $1}' | grep -v "^Topics"
}
__eg_topiclist=
__eg_topiclist="$(__eg_topics 2>/dev/null)"

_eg_commit ()
{
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "$cur" in
  --*)
    __gitcomp "
      --all-tracked --bypass-untracked-check --staged --dirty
      --author= --signoff --verify --no-verify
      --edit --amend --include --only
      "
    return
  esac
  COMPREPLY=()
}

_eg_diff ()
{
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "$cur" in
  --*)
    __gitcomp "--staged --unstaged
      --cached --stat --numstat --shortstat --summary
      --patch-with-stat --name-only --name-status --color
      --no-color --color-words --no-renames --check
      --full-index --binary --abbrev --diff-filter
      --find-copies-harder --pickaxe-all --pickaxe-regex
      --text --ignore-space-at-eol --ignore-space-change
      --ignore-all-space --exit-code --quiet --ext-diff
      --no-ext-diff"
    return
    ;;
  esac
  __git_complete_file
}

_eg_help ()
{
  local i c=1 command
  while [ $c -lt $COMP_CWORD ]; do
    i="${COMP_WORDS[c]}"
    case "$i" in
    topic) command="$i"; break ;;
    esac
    c=$((++c))
  done

  if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
    local cur="${COMP_WORDS[COMP_CWORD]}"
    case "$cur" in
    --*)
      __gitcomp "--all"
      return
      ;;
    esac
    __gitcomp "$(__eg_commands) topic"
  else
    __gitcomp "$(__eg_topics)"
  fi
}

_eg_reset ()
{
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "$cur" in
  --*)
    __gitcomp "--working-copy --no-unstaging --mixed --hard --soft"
    return
    ;;
  esac
  __gitcomp "$(__git_refs)"
}

_eg_revert ()
{
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "$cur" in
  --*)
    __gitcomp "--commit --no-commit --staged --in --since"
    return
    ;;
  esac
  __git_complete_file
}

_eg ()
{
  local i c=1 command __git_dir

  while [ $c -lt $COMP_CWORD ]; do
    i="${COMP_WORDS[c]}"
    case "$i" in
    --git-dir=*) __git_dir="${i#--git-dir=}" ;;
    --bare)      __git_dir="." ;;
    --version|-p|--paginate) ;;
    --help)      command="help"; break ;;
    --translate|--debug) ;;
    *) command="$i"; break ;;
    esac
    c=$((++c))
  done

  if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
    case "${COMP_WORDS[COMP_CWORD]}" in
    --*=*) COMPREPLY=() ;;
    --*)   __gitcomp "
      --debug
      --translate
      --no-pager
      --git-dir=
      --bare
      --version
      --exec-path
      "
      ;;
    *)     __gitcomp "$(__eg_commands) $(__git_aliases)" ;;
    esac
    return
  fi

  local expansion=$(__git_aliased_command "$command")
  [ "$expansion" ] && command="$expansion"

  case "$command" in
  am)          _git_am ;;
  add)         _git_add ;;
  apply)       _git_apply ;;
  archive)     _git_archive ;;
  bisect)      _git_bisect ;;
  bundle)      _git_bundle ;;
  branch)      _git_branch ;;
  checkout)    _git_checkout ;;
  cherry)      _git_cherry ;;
  cherry-pick) _git_cherry_pick ;;
  clean)       _git_clean ;;
  clone)       _git_clone ;;
  commit)      _eg_commit ;;
  config)      _git_config ;;
  describe)    _git_describe ;;
  diff)        _eg_diff ;;
  fetch)       _git_fetch ;;
  format-patch) _git_format_patch ;;
  gc)          _git_gc ;;
  grep)        _git_grep ;;
  help)        _eg_help ;;
  init)        _git_init ;;
  log)         _git_log ;;
  ls-files)    _git_ls_files ;;
  ls-remote)   _git_ls_remote ;;
  ls-tree)     _git_ls_tree ;;
  merge)       _git_merge;;
  mergetool)   _git_mergetool;;
  merge-base)  _git_merge_base ;;
  mv)          _git_mv ;;
  name-rev)    _git_name_rev ;;
  pull)        _git_pull ;;
  push)        _git_push ;;
  rebase)      _git_rebase ;;
  remote)      _git_remote ;;
  reset)       _eg_reset ;;
  revert)      _eg_revert ;;
  rm)          _git_rm ;;
  send-email)  _git_send_email ;;
  shortlog)    _git_shortlog ;;
  show)        _git_show ;;
  show-branch) _git_log ;;
  stage)       _git_add ;;
  stash)       _git_stash ;;
  submodule)   _git_submodule ;;
  svn)         _git_svn ;;
  switch)      _git_checkout ;;
  tag)         _git_tag ;;
  # unstage)     COMPREPLY=() ;;  ## Already handled by default case
  whatchanged) _git_log ;;
  *)           COMPREPLY=() ;;
  esac
}

complete -o default -o nospace -F _eg eg

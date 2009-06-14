#  -*- mode: python -*-

# Load a few useful modules:
import os

# Tab completion:
import rlcompleter, readline

# This works with GNU readline:
def __use_readline():
    readline.parse_and_bind('tab: complete')

# This works with BSD editline:
def __use_editline():
    readline.parse_and_bind('bind ^I rl_complete')

# Note that OS X.5 (Leopard) uses the latter!
# Note also that editline happily ignores the former definition,
#  while readline silently corrupts the REPL when parsing the latter.
__use_readline()

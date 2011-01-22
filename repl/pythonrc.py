#  -*- mode: python -*-
# python(1)

# Default modules
import os, sys

# Pretty-printing
from pprint import pprint as pp

# Line editing
try:
    import readline, rlcompleter
    readline.parse_and_bind('tab: complete')        # GNU readline
    # readline.parse_and_bind('bind ^I rl_complete')  # BSD editline
    del readline, rlcompleter
except ImportError:
    pass

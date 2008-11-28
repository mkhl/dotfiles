#  -*- mode: python -*-

# Load a few useful modules:
import os, time, glob, tempfile
import re, string, StringIO, pickle
import itertools, functools
import array, struct
import urllib, urllib2, urlparse
import rlcompleter, readline

# Tab completion:
# This works with GNU readline:
# readline.parse_and_bind('tab: complete')
# This works with BSD EditLine:
readline.parse_and_bind('bind ^I rl_complete')
# Note that OS X.5 (Leopard) uses the latter!

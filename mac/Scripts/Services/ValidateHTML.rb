#!/usr/bin/env ruby -rubygems

# Unicode considerations:
#  Set $KCODE to 'u'. This makes STDIN and STDOUT both act as containing UTF-8.
$KCODE = 'u'

require "cgi"
require "launchy"

Launchy.open("http://validator.w3.org/check?fragment=#{CGI.escape(STDIN.gets(nil))}")

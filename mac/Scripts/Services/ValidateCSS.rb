#!/usr/bin/env ruby -rubygems

# Unicode considerations:
#  Set $KCODE to 'u'. This makes STDIN and STDOUT both act as containing UTF-8.
$KCODE = 'u'

require "cgi"
require "launchy"

Launchy.open("http://jigsaw.w3.org/css-validator/validator?text=#{CGI.escape(STDIN.gets(nil))}")

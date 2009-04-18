#!/usr/bin/env ruby -wKU
# -*- coding: utf-8 -*-

print ARGF.read.gsub(/(;)?\s+\{$/, ';')

#!/usr/bin/env ruby -w

ext('erb') { |file, dest| sh %[erb -r yaml <#{file} >#{dest}] }

hide %w[etc scm repl]
show %w[bin]

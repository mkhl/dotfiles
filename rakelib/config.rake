!#!/usr/bin/env ruby -w

$config = 'private/config.yml'
ENV['CONFIG'] = $config

file $config do
  sh %[git clone git@mkhl.unfuddle.com:mkhl/private.git]
end

task :all => $config

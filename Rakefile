#!/usr/bin/env ruby -w

require "find"

DESTDIR = File.expand_path(ENV['DESTDIR'] or '~')

$extmap = {}
$symlink = proc { |file, dest| ln_sf File.expand_path(file), dest }

def ext(name, &proc)
  $extmap[name] = proc
end

def extmap(path)
  proc = $extmap[path.pathmap('.%x')]
  return [path.pathmap('%X'), proc] if proc
  [path, $symlink]
end

def hide(paths)
  paths.each { |p| dir(p, '.') }
end

def show(paths)
  paths.each { |p| dir(p, p+'/') }
end

def dir(base, dest)
  register_dir(base, File.join(DESTDIR, dest))
end

def register_dir(basedir, destdir)
  desc "Install files from subdirectory #{basedir}"
  task basedir
  task :all => basedir
  Find.find(basedir) do |path|
    Find.prune if File.basename(path)[0] == ?.
    next if File.directory?(path)
    register(basedir, destdir, path)
  end
end

def register(basedir, destdir, path)
  path, proc = extmap(path)
  dest = path.sub(basedir+'/', destdir)
  parent = dest.pathmap('%d')
  directory parent
  file dest => [parent, path] do
    proc[path, dest]
  end
  task basedir => dest
end

desc "Install files from all subdirectories"
task :all
task :default => :all

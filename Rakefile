#  -*- mode: ruby -*-

verbose(true) if verbose == :default

BASEDIR = File.expand_path(File.dirname(__FILE__))
HOMEDIR = File.expand_path(ENV['DESTDIR'] || '~')

@known_filetypes = {}
@private_data = 'private/data.rb'
@private_files = []

def basedir(*paths)
  File.join BASEDIR, *paths
end

def homedir(*paths)
  File.join HOMEDIR, *paths
end

def with(*values, &block)
  yield(*values)
end


def symlink_file(src, dest)
  ln_sf File.expand_path(src), dest
end

def symlink_dir(src, dest)
  if File.exists? dest
    return unless File.symlink? dest
    rm_f dest
  end
  ln_sf File.expand_path(src), dest
end

def install_file(src, dest)
  install src, dest
end

def install_dir(src, dest)
  cp_r src, dest
end

alias :handle_file :symlink_file
alias :handle_dir  :symlink_dir


def mirror_file(src, dest, dir = nil)
  ext = src.pathmap('%x')
  if @known_filetypes.include? ext
    dest = @known_filetypes[ext][src, dest]
  else
    unless dir.nil?
      directory dir
      file dest => dir
    end
    file dest => src do
      handle_file src, dest
    end
  end
  task :all => dest
end

def mirror_dir(src, dest)
  file dest => src do
    handle_dir src, dest
  end
  task :all => dest
end

def mirror(src, dest, shallow, ignored)
  return if ignored[src]

  if File.file? src
    mirror_file src, dest
  elsif shallow
    mirror_dir src, dest
  else
    FileList[File.join(src, '**', '*')].each do |srcfile|
      next if File.directory? srcfile
      next if ignored[srcfile]
      destfile = srcfile.pathmap("%{^#{src},#{dest}}p")
      mirror_file srcfile, destfile, File.dirname(destfile)
    end
  end
end


def filetype(ext, &block)
  @known_filetypes[ext.to_s] = block
  @known_filetypes[".#{ext.to_s}"] = block
end

def submodule_tasks(name, subdir, destdir)
  directory destdir
  desc "Install the files under #{subdir}"
  task name => [destdir, "#{subdir}:all"]
  desc "Install the files under #{subdir} through copying"
  task "#{name}:copy" do
    alias :handle_file :install_file
    alias :handle_dir  :install_dir
    Rake::Task[name].invoke
  end
  desc "Install the files under #{subdir} through symbolic links"
  task "#{name}:link" do
    alias :handle_file :symlink_file
    alias :handle_dir  :symlink_dir
    Rake::Task[name].invoke
  end
  task :all => name
end

def submodule_options(subdir, options)
  subjoin = proc { |p| File.join(subdir, p) }
  excludes = FileList[options.fetch(:exclude, []).map(&subjoin)]
  shallows = FileList[options.fetch(:shallow, []).map(&subjoin)]
  privates = FileList[options.fetch(:private, []).map(&subjoin)]
  ignores = options.fetch(:ignore, []).map { |p| File.join('**', p) }
  subfiles = FileList[subjoin['*']]
  subfiles.exclude(subjoin["#{subdir}.rake"])
  subfiles.exclude(*excludes)
  subfiles.exclude(*ignores)
  @private_files += privates.existing
  [excludes, shallows, subfiles]
end

def submodule(subdir, destdir, pathmap, options = {})
  name = subdir.to_sym
  subdir = subdir.to_s
  excludes, shallows, subfiles = submodule_options(subdir, options)
  ignored = proc { |f| subfiles.exclude? f }

  namespace name do
    subfiles.each do |src|
      dest = File.join(destdir, src.pathmap(pathmap))
      mirror src, dest, shallows.include?(src), ignored
    end
  end
  submodule_tasks(name, subdir, destdir)
end


filetype :erb do |src, dest|
  dest = dest.ext('')
  dir = File.dirname dest
  if @private_files.include? src
    file dest => [@private_data, dir, src] do
      sh %[erb -r ./private/data.rb <#{src} >#{dest}]
    end
  else
    file dest => [dir, src] do
      sh %[erb <#{src} >#{dest}]
    end
  end
  dest
end

file @private_data do
  sh "./fetch-private.sh"
end

desc "Install all files from all subdirectories"
task :all

desc "Install all files through copying"
task "all:copy" do
  alias :handle_file :install_file
  alias :handle_dir  :install_dir
  Rake::Task[:all].invoke
end

desc "Install all files through symbolic links"
task "all:link" do
  alias :handle_file :symlink_file
  alias :handle_dir  :symlink_dir
  Rake::Task[:all].invoke
end

task :default do
  Rake.application.options.show_tasks = true
  Rake.application.options.show_task_pattern = //
  Rake.application.options.full_description = false
  Rake.application.display_tasks_and_comments
end

FileList['*/*.rake'].each do |rakefile|
  dirname = File.basename(File.dirname(rakefile))
  basename = File.basename(rakefile.ext(''))
  import rakefile  if dirname == basename
end

desc 'Just show what would be done'
task :dryrun do
  nowrite(true)
end

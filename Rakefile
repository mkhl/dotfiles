verbose(true) if verbose == :default

BASEDIR = File.expand_path(File.dirname(__FILE__))
HOMEDIR = File.expand_path(ENV['DESTDIR'] || '~')
VALID_MODES = [:copy, :install, :link, :symlink]
DEFAULT_MODE = :symlink

@known_filetypes = {}
@install_mode = :default

def basedir(*paths)
  File.join BASEDIR, *paths
end

def homedir(*paths)
  File.join HOMEDIR, *paths
end

def with(*values, &block)
  yield(*values)
end


def set_install_mode(mode)
  mode = mode.to_sym
  @install_mode = (VALID_MODES.include? mode) ? mode : nil
end

def install_file(src, dest, dir = nil)
  ext = src.pathmap('%x')
  if @known_filetypes.include? ext
    @known_filetypes[ext][src, dest]
  else
    unless dir.nil?
      directory dir
      task dest => dir
    end
    file dest => src do
      @install_mode = DEFAULT_MODE if @install_mode == :default
      case @install_mode
      when :link, :symlink
        ln_sf File.expand_path(src), dest
      when :copy, :install
        install File.expand_path(src), dest
      end
    end
    task :all => dest
  end
end

def install_dir(src, dest)
  file dest => src do
    @install_mode = DEFAULT_MODE if @install_file == :default
    case @install_mode
    when :link, :symlink
      if File.exists? dest
        return unless File.symlink? dest
        rm_f dest
      end
      ln_sf File.expand_path(src), dest
    when :copy, :install
      cp_r File.expand_path(src), dest
    end
  end
  task :all => dest
end

def mirror(src, dest, shallow, ignored)
  return if ignored[src]

  if File.file? src
    install_file src, dest
  elsif shallow
    install_dir src, dest
  else
    FileList[File.join(src, '**', '*')].each do |srcfile|
      next if File.directory? srcfile
      next if ignored[srcfile]
      destfile = srcfile.pathmap("%{^#{src},#{dest}}p")
      install_file srcfile, destfile, File.dirname(destfile)
    end
  end
end

def filetype(ext, &block)
  @known_filetypes[ext] = block
  @known_filetypes[".#{ext}"] = block
end

def submodule(subdir, destdir, pathmap, options = {})
  name = subdir.to_sym
  subdir = name.to_s unless subdir.is_a? String
  subjoin = proc { |p| File.join(subdir, p) }
  excludes = FileList[options.fetch(:exclude, []).map(&subjoin)]
  shallows = FileList[options.fetch(:shallow, []).map(&subjoin)]
  subfiles = FileList[subjoin['*']].exclude(subjoin["#{subdir}.rake"])
  ignored = proc do |f|
    options.fetch(:ignore, []).any? { |p| File.fnmatch?(p, File.basename(f)) }
  end

  directory destdir
  namespace name do
    subfiles.exclude(*excludes).each do |src|
      dest = File.join(destdir, src.pathmap(pathmap))
      mirror src, dest, shallows.include?(src), ignored
    end
  end
  desc "Install the dotfiles under #{subdir}"
  task name => [destdir, "#{subdir}:all"]
  task :all => name
end


desc "Install all dotfiles from all subdirectories"
task :all

task :default do
  Rake.application.options.show_tasks = true
  Rake.application.options.show_task_pattern = //
  Rake.application.options.full_description = false
  Rake.application.display_tasks_and_comments
end

FileList['*/*.rake'].each do |rakefile|
  # Rake.application.rake_require rakefile.ext
  import rakefile
end

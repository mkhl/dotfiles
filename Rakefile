
verbose(false) if verbose == :default
BASEDIR = File.expand_path(File.dirname(__FILE__))
HOMEDIR = File.expand_path('~')
TARGETS = [:install, :symlink]

def basedir(*paths)
  File.join BASEDIR, *paths
end

def homedir(*paths)
  File.join HOMEDIR, *paths
end

def with(*values, &block)
  yield(*values)
end


def do_install(from, to)
  install basedir(from), to
end

def do_symlink(from, to)
  if File.directory? to
    return unless File.symlink? to
    rm_f to
  end
  ln_sf basedir(from), to
end

def list_files(dir)
  FileList[File.join(dir, '*')].exclude("#{dir}/#{dir}.rake")
end

def register_files(dir, recurse = true)
  base = dir.to_sym
  list_files(dir).each do |from|
    to = yield(from) if block_given?
    to ||= from.pathmap(homedir('.%f'))
    if recurse and File.directory? from
      list_files(from).each do |file|
        from_to base, file, File.join(to, File.basename(file)), to
      end
    else
      from_to base, from, to
    end
  end
  TARGETS.each do |action|
    namespace action do
      task base => "#{action}:#{base}:all"
    end
    task action => "#{action}:#{base}"
  end
end

def from_to(base, from, to, dir = nil)
  TARGETS.each do |action|
    namespace action do
      namespace base do
        task_name = "#{action}_#{from}"
        task task_name do
          mkdir_p dir unless dir.nil?
          self.__send__("do_#{action}", from, to)
        end
        task :all => task_name
      end
    end
  end
end

FileList['*/*.rake'].each do |rakefile|
  # Rake.application.rake_require rakefile.ext
  import rakefile

  subtree = File.dirname rakefile
  TARGETS.each do |action|
    namespace action do
      desc "Invoke #{action} for the dotfiles under #{subtree}"
      task subtree
    end
  end
end


desc "Install copies of the dotfiles into your $HOME"
task :install

desc "Create symlinks to the dotfiles in your $HOME"
task :symlink

namespace :dryrun do
  TARGETS.each do |action|
    desc "Just show which actions #{action}ing would invoke"
    task action do
      verbose(true) { nowrite(true) { Rake::Task[action].invoke } }
    end
  end
end

desc "Just show what would be done"
task :dryrun do
  TARGETS.each do |action|
    puts "Dry-running #{action}..." if verbose
    Rake::Task["dryrun:#{action}"].invoke
  end
end

task :default do
  with(Rake.application) do |app|
    app.options.show_tasks = true
    app.options.show_task_pattern = //
    app.options.full_description = false
    app.display_tasks_and_comments
  end
end
with File.basename(File.dirname(__FILE__)) do |base|
  register_files(base) { |file| file.pathmap(homedir('bin', '%f')) }
end
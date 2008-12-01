with File.basename(File.dirname(__FILE__)) do |base|
  mirror base, homedir, '.%f', :shallow => FileList[File.join(base, '*.d')]
end
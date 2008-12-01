with File.basename(File.dirname(__FILE__)) do |base|
  mirror base, homedir('bin'), '%f'
end
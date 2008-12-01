with File.basename(File.dirname(__FILE__)) do |base|
  mirror base, homedir('Library'), '%f', :exclude => 'Scripts'
end

# def applet_icon(file, type = '*')
#   file.pathmap("%d/%{.*,*}n-#{type}.icns") { |name| name.gsub(/\s+/, '').downcase }
# end
# 
# rule '.scpt' => ['.applescript'] do |task|
#   sh "osacompile -o '#{task.name}' '#{task.source}'"
# end
# 
# rule '.app' => ['.applescript'] do |task|
#   # Create the applet bundle
#   sh "osacompile -o '#{task.name}' '#{task.source}'"
#   # Make the applet "faceless"
#   plist = File.expand_path(File.join(task.name, 'Contents', 'Info'))
#   sh "defaults write '#{plist}' NSUIElement -int 1"
#   # Include the custom icon
#   type = `defaults read '#{plist}' CFBundleIconFile`.chomp
#   icon = applet_icon(task.source, type)
#   copy icon, File.join(task.name, 'Contents', 'Resources', "#{type}.icns")
# end
# 
# register_type 'applescript' do |infile|
#   imgname = applet_icon(infile)
#   return infile.ext('scpt') if FileList[imgname].existing.to_a.empty?
#   infile.ext('app')
# end
# 
# with File.basename(File.dirname(__FILE__)) do |base|
#   register_files base, File.join('Library', '%f')
# end
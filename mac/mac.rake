filetype :applescript do |src, dest|
  icon = src.pathmap("%d/%{.*,*}n-*.icns") { |x| x.gsub(/\s+/, '').downcase }
  icon = FileList[icon].existing.first
  if icon.nil?
    install_script src, dest.ext('scpt')
  else
    install_applet src, dest.ext('app'), icon
  end
end

def install_script(src, dest)
  dir = File.dirname dest
  directory dir
  file dest => [src, dir] do
    sh "osacompile -o '#{dest}' '#{src}'"
  end
  dest
end

def install_applet(src, dest, srcicon)
  dir = File.dirname dest
  directory dir
  file dest => [src, srcicon, dir] do
    # Create the applet bundle
    sh "osacompile -o '#{dest}' '#{src}'"
    # Make the applet "faceless"
    plist = File.expand_path(File.join(dest, 'Contents', 'Info'))
    sh "defaults write '#{plist}' NSUIElement -int 1"
    # Install the custom icon
    type = srcicon.pathmap('%{.*-,}n')
    desticon = File.join(dest, 'Contents', 'Resources', "#{type}.icns")
    copy srcicon, desticon
    # Update the timestamp, in case the bundle existed before
    sh "touch '#{dest}'"
  end
  dest
end

submodule :mac, homedir('Library'), '%f', :ignore => ['*.icns']

projects = home["Projects/"]
src = home["src/"]
ext = src["ext/"]
begin
  require "appscript"
  require "osax"
  prefs = root[OSAX::osax.path_to(:preferences, :from => :user_domain).path + '/']
  appsup = root[OSAX::osax.path_to(:application_support, :from => :user_domain).path + '/']
  mate = appsup['TextMate/']
  esp = appsup['Espresso/']
  $prefs = root[OSAX.osax.path_to(:preferences, :from => :local_domain).path + '/']
  $appsup = root[OSAX.osax.path_to(:application_support, :from => :local_domain).path + '/']
  $mate = $appsup['TextMate/']
rescue LoadError
  nil
end

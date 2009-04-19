require "osx/cocoa"
# include OSX

user_path = lambda { |dir| root[OSX::NSSearchPathForDirectoriesInDomains(dir, OSX::NSUserDomainMask, true).first.to_s] }
root_path = lambda { |dir| root[OSX::NSSearchPathForDirectoriesInDomains(dir, OSX::NSLocalDomainMask, true).first.to_s] }

projects = home['Projects']
bin = home['bin']
src = home['src']
ext = src['ext']
qsb = src['blacktree/qsb-mac']

prefs = user_path[OSX::NSLibraryDirectory]['Preferences']
appsup = user_path[OSX::NSApplicationSupportDirectory]
mate = appsup['TextMate']
esp = appsup['Espresso']

$prefs = root_path[OSX::NSLibraryDirectory]['Preferences']
$appsup = root_path[OSX::NSApplicationSupportDirectory]
$mate = $appsup['TextMate']

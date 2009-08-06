require "osx/cocoa"
# include OSX

user_path = lambda { |dir| root[OSX::NSSearchPathForDirectoriesInDomains(dir, OSX::NSUserDomainMask, true).first.to_s] }
root_path = lambda { |dir| root[OSX::NSSearchPathForDirectoriesInDomains(dir, OSX::NSLocalDomainMask, true).first.to_s] }

projects = home['Projects']
cocoa = projects['Cocoa']
hets = projects['Hets/Hets']
bin = home['bin']
src = home['src']
ext = src['ext']
qsb = src['alchemy/qsb-mac']

prefs = user_path[OSX::NSLibraryDirectory]['Preferences']
appsup = user_path[OSX::NSApplicationSupportDirectory]
mate = appsup['TextMate']
espresso = appsup['Espresso']

$prefs = root_path[OSX::NSLibraryDirectory]['Preferences']
$appsup = root_path[OSX::NSApplicationSupportDirectory]
$mate = $appsup['TextMate']

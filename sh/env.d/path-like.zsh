# Set up search path variables
typeset -T INFOPATH infopath
typeset -T DYLD_FRAMEWORK_PATH dyld_framework_path
typeset -T DYLD_LIBRARY_PATH dyld_library_path
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -T PERL5LIB perl5lib
typeset -T PYTHONPATH pythonpath
typeset -T RUBYLIB rubylib

# Ignore duplicates
typeset -U path
typeset -U manpath
typeset -U infopath
typeset -U dyld_framework_path
typeset -U dyld_library_path
typeset -U ld_library_path
typeset -U perl5lib
typeset -U pythonpath
typeset -U rubylib

# Set library search path variables
perl5lib=(
	$HOME/lib/perl
	$perl5lib
)
pythonpath=(
	$HOME/lib/python
	$pythonpath
)
rubylib=(
	$HOME/lib/ruby
	$rubylib
)

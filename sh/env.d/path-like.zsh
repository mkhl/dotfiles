# Set up search path variables
typeset -xT INFOPATH infopath
typeset -xT DYLD_FRAMEWORK_PATH dyld_framework_path
typeset -xT DYLD_LIBRARY_PATH dyld_library_path
typeset -xT LD_LIBRARY_PATH ld_library_path
typeset -xT PERL5LIB perl5lib
typeset -xT PYTHONPATH pythonpath
typeset -xT RUBYLIB rubylib
typeset -xT CLASSPATH classpath

# Ignore duplicates
typeset -xU path
typeset -xU manpath
typeset -xU infopath
typeset -xU dyld_framework_path
typeset -xU dyld_library_path
typeset -xU ld_library_path
typeset -xU perl5lib
typeset -xU pythonpath
typeset -xU rubylib
typeset -xU classpath

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

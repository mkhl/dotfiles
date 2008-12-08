# ri completion for Ruby documentation by Ian Macdonald <ian@caliban.org>
#
# $Id: ri,v 1.8 2006/02/25 14:25:59 ianmacd Exp $
#
ri_get_methods()
{
	local regex

	if [ "$ri_version" = integrated ]; then
	  if [ -z "$separator" ]; then
	    regex="(Instance|Class)"
	  elif [ "$separator" = "#" ]; then
	    regex=Instance
	  else
	    regex=Class
	  fi

	  COMPREPLY=( ${COMPREPLY[@]} \
	    "$( ri ${classes[@]} 2>/dev/null | \
	      ruby -ane 'if /^'"$regex"' methods:/.../^------------------|^$/ and \
	      /^ / then print $_.split(/, |,$/).grep(/^[^\[]*$/).join("\n"); \
	      end' | sort -u )" )
	else
	  # older versions of ri didn't distinguish between class/module and
	  # instance methods
	  COMPREPLY=( ${COMPREPLY[@]} \
	    "$( ruby -W0 $ri_path ${classes[@]} | ruby -ane 'if /^-/.../^-/ and \
	      ! /^-/ and ! /^ +(class|module): / then \
	      print $_.split(/, |,$| +/).grep(/^[^\[]*$/).join("\n"); \
	      end' | sort -u )" )
	fi
	COMPREPLY=( $( compgen $prefix -W '${COMPREPLY[@]}' -- $method ) )
}

# needs at least Ruby 1.8.0 in order to use -W0
_ri()
{
	local cur class method prefix ri_path ri_version separator IFS
	local -a classes

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}

	ri_path=$(type -p ri)
	# which version of ri are we using?
	# -W0 is required here to stop warnings from older versions of ri
	# from being captured when used with Ruby 1.8.1 and later
	ri_version="$(ruby -W0 $ri_path -v 2>&1)" || ri_version=integrated
	[ "$ri_version" != "${ri_version%200*}" ] && ri_version=integrated

	# need to also split on commas
	IFS=$', \n\t'
	if [[ "$cur" == [A-Z]*[#.]* ]]; then
	  [[ "$cur" == *#* ]] && separator=# || separator=.
	  # we're completing on class and method
	  class=${cur%$separator*}
	  method=${cur#*$separator}
	  classes=( $class )
	  prefix="-P $class$separator"
	  ri_get_methods 
	  return 0
	fi

	if [ "$ri_version" = integrated ]; then
	  # integrated ri from Ruby 1.9
	  classes=( $( ri -c | ruby -ne 'if /^\s*$/..$stdin.eof then \
				      if /, [A-Z]+/ then print; end; end' ) )
	elif [ "$ri_version" = "ri 1.8a" ]; then
	  classes=( $( ruby -W0 $ri_path | \
		       ruby -ne 'if /^'"'"'ri'"'"' has/..$stdin.eof then \
				 if /^ .*[A-Z]/ then print; end; end' ))
	else
	  classes=( $( ruby -W0 $ri_path | \
		       ruby -ne 'if /^I have/..$stdin.eof then \
				 if /^ .*[A-Z]/ then print; end; end' ))
	fi

	COMPREPLY=( $( compgen -W '${classes[@]}' -- $cur ) )
	if [[ "$cur" == [A-Z]* ]]; then
	  # we're completing on class or module alone
	  return 0
	fi

	# we're completing on methods
	method=$cur
	ri_get_methods
}
complete -F _ri ri

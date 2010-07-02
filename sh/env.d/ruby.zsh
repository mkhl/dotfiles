# Ruby load path
if command -v brew &>/dev/null; then
	BREWBY_PATH="$(brew --cellar)/gems/rpg"
	BREWBY_ARCH="$(ruby -rrbconfig -e 'print RbConfig::CONFIG["arch"]')"
	rubylib=(
		"$BREWBY_PATH/ruby/1.8"
		"$BREWBY_PATH/ruby/1.8/$BREWBY_ARCH"
	)
	unset -v BREWBY_ARCH BREWBY_PATH
fi

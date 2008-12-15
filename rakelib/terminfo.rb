#!/usr/bin/env ruby -wKU

@term_dumb    = { :hs => false }
@term_sun_cmd = { :hs => true, :ts => '\E]l', :fs => '\E\\\\' }
@term_ansi    = { :hs => true, :ts => '\E]2;',  :fs => '\007' }
@term_screen  = { :hs => true, :ts => '\Ek', :fs => '\E\\\\' }

@term_types = {
  @term_dumb => %w[
    dumb
    linux
    sun
    emacs
  ],
  @term_ansi => %w[
    ansi
    dtterm
    eterm
    Eterm
    iris-ansi
    mlterm
    rxvt*
    xterm*
  ],
  @term_sun_cmd => %w[
    sun-cmd
  ],
  @term_screen => %w[
    screen
    screen-w
  ],
}

def to_pattern(types)
  types.join('|')
end

def to_title(term)
  if term[:hs]
    # "PROMPT_HS=t; PROMPT_TS=#{term[:ts]}; PROMPT_FS=#{term[:fs]}"
    <<-SHELL
        PROMPT_HS=t
        PROMPT_TS="#{term[:ts]}"
        PROMPT_FS="#{term[:fs]}"
SHELL
  else
    <<-SHELL
        unset -v PROMPT_HS PROMPT_TS PROMPT_FS
SHELL
  end.chomp
end

def to_screen(term)
  if term[:hs]
    "hs:ts=#{term[:ts]}:fs=#{term[:fs]}:ds=#{term[:ts]}screen#{term[:fs]}"
  else
    "hs@"
  end
end

def sh
  cases = @term_types.collect do |term, types|
    "#{to_pattern(types)})\n#{to_title(term)}\n#{' ' * 8};;"
  end
  cases << "*)\n#{to_title(@term_dumb)}\n#{' ' * 8};;"
  <<-SHELL
# Set HS, TS and FS if $TERM supports them
case "$TERM" in
    #{cases.join("\n#{' ' * 4}").chomp}
esac
SHELL
end

def screen
  lines = @term_types.collect do |term, types|
    types.reject! { |t| /^screen(-w)?$/ === t }
    next if types.empty?
    "termcapinfo #{to_pattern(types)} '#{to_screen(term)}'"
  end
  lines.join("\n")
end

if __FILE__ == $PROGRAM_NAME
  if '--screen' == ARGV.first
    puts screen
  else
    puts sh
  end
end
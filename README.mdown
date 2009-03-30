# mkhl’s dotfiles

Yet another collection of dotfiles.


## Installation

Just run:

    rake all:copy

to install copies of all the files into your home directory.

    rake all:link

to create symlinks to all the files in your home directory.

    rake dryrun all

to check out what’s going on before installing random files off the internet.

    rake

to find out more.


## Caveats

This package includes some files you'll **not** want to install, like my SSH
public key. You should replace it with your own key, or just remove it from
your clone entirely. And you should *definitely* review random files you want
to install from the internet!
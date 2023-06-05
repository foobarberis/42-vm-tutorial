## Set $PATH, which tells the computer where to search for commands
export PATH="$PATH:/usr/sbin:/sbin:/bin:/usr/bin:/etc:/usr/ucb:/usr/local/bin:/usr/local/local_dfs/bin:/usr/bin/X11:/usr/local/sas:$HOME/.scripts/:$HOME/.local/bin"

## Where to search for manual pages
export MANPATH="/usr/share/man:/usr/local/man:/usr/local/local_dfs/man"

## Which pager to use.
export PAGER=less

## Choose your weapon
export EDITOR=/usr/bin/vim

## The maximum number of lines in your history file
export HISTFILESIZE=50

## Enables displaying colors in the terminal
export TERM=xterm-256color

## Disable automatic mail checking
unset MAILCHECK

## Automatically correct mistyped 'cd' directories
shopt -s cdspell

## Append to history file; do not overwrite
shopt -s histappend

## Prevent accidental overwrites when using IO redirection
set -o noclobber

# Aliases
alias l='ls -Alhp --group-directories-first --color'
alias off='sudo shutdown now'
alias res-desktop='xrandr -s 1920x1200_60.00'
alias res-laptop='xrandr -s 1680x1050_60.00'
alias upd='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get clean'
alias ccd='cc -Wall -Wextra -g3 -fsanitize=address,undefined'
alias vg='valgrind --show-reachable=no --leak-check=full --show-leak-kinds=all --track-origins=yes'

## Git
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'

## Navigation
alias b='cd ../'

# Personal PS1
PS1='\[\e[0m\]\W \[\e[0m\]$ \[\e[0m\]'

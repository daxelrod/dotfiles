# Default programs
export EDITOR=vim

# History
shopt -s histappend # Add to history file instead of overwriting
HISTCONTROL=ignorespace # Don't save lines starting with space
HISTSIZE=65536 # Lines
HISTFILESIZE=65536 # Lines

# Update LINES and COLUMNS after a process completes
shopt -s checkwinsize

# Mac OS X's default terminal prompt
PS1='\h:\W \u\$ '

# vim: ft=config cms=#%s
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# List files
#
# list with color by default
alias ls='ls --color=auto'
# list links
alias ll='find . -maxdepth 1 -type l | xargs -i ls -al {} | column -t'
# list executable
alias lx='find . -maxdepth 1 -type f -executable'
# list hidden
alias lh='ls -al | grep " \."'

## youtube download add queue entry to YTTODO file
alias yttd='echo youtube-dl -o "\"%(uploader)s-%(title)s-%(id)s.%(ext)s"\" $@ >> YTTODO'

#
# Exports
#
# vim as default editor
export EDITOR=vim
export TZ='Asia/Bangkok'
export XDG_CONFIG_HOME=~/.config
export PS1="[\u@ \w] \n$ "

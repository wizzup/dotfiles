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
alias yttd='echo youtube-dl -f "\"bestvideo[height<=?720]+bestaudio/best"\" -o "\"%(uploader)s-%(title)s-%(id)s.%(ext)s"\" $@ >> YTTODO'

#
# Exports
#
# vim as default editor
export EDITOR=nvim
export TZ='Asia/Bangkok'
export PS1="[\u@ \w] \n$ "

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# suppress GTK accessibility warning
export NO_AT_BRIDGE=1

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls --color=auto -A'
alias ll='ls --color=auto -l'
alias lla='ls --color=auto -lA'
alias l.='ls --color=auto -d .*'
alias ll.='ls --color=auto -dl .*'
alias lx='find . -type f -executable -maxdepth 1'
alias vless='/usr/share/vim/vim73/macros/less.sh'
alias ydt='youtube-dl -t'
alias yttd='echo "youtube-dl -t $@" >> YTTODO'
alias ar2c3='aria2c -x3 -c'
alias artodo='echo "aria2c -x3 -c $@" >> ARTODO'

export TZ='Asia/Bangkok'

PS1='[\u@\h \W]\$ '

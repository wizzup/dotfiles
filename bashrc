#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## list files alias
alias ls='ls --color=auto'
alias ll='find . -maxdepth 1 -type l | xargs -i ls -al {} | column -t'
alias lx='find . -maxdepth 1 -type f -executable'

## youtube download queue
alias yttd='echo youtube-dl -o "\"%(uploader)s-%(title)s-%(id)s.%(ext)s"\" $@ >> YTTODO'

#alias vim='nvim'
#alias vless='/usr/share/vim/vim73/macros/less.sh'
#alias ar2c3='aria2c -x3 -c'
#alias artodo='echo "aria2c -x3 -c $@" >> ARTODO'

## exports
export TZ='Asia/Bangkok'
export PS1='[\u@\h \W]\$ '
export PATH=~/.local/bin:$PATH

#export WORKON_HOME=~/.virtualenvs
#source /usr/bin/virtualenvwrapper.sh

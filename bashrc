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
# alias yttd='echo youtube-dl -o "\"%(uploader)s-%(title)s-%(id)s.%(ext)s"\" $@ >> YTTODO'
alias yttd='echo youtube-dl -f "\"bestvideo[height<=?720]+bestaudio/best"\" -o "\"%(uploader)s-%(title)s-%(id)s.%(ext)s"\" $@ >> YTTODO'

#
# Exports
#
# vim as default editor
export EDITOR=vim
export TZ='Asia/Bangkok'
export PS1="[\u@ \w] \n$ "

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

## nix ghc-paths envs
NIX_GHC_VERSION=$(ghc --numeric-version)
export NIX_GHC="/run/current-system/sw/bin/ghc"
export NIX_GHCPKG="/run/current-system/sw/bin/ghc-pkg"
export NIX_GHC_LIBDIR="/run/current-system/sw/lib/ghc-${NIX_GHC_VERSION}"
# export NIX_GHC_DOCDIR="/run/current-system/sw/share/doc/ghc/html"

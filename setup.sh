#!/usr/bin/env bash
# create symlinks of configuration files

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR

[[ -e $XDG_CONFIG_HOME ]] || echo "XDG_CONFIG_HOME is not defined"

echo 'creating configuration directories'
mkdir -pv $XDG_CONFIG_HOME/nvim
mkdir -pv $XDG_CONFIG_HOME/nvim/after
mkdir -pv $XDG_CONFIG_HOME/termite
mkdir -pv $XDG_CONFIG_HOME/nixpkgs
mkdir -pv ~/.xmonad

echo 'installing symlinks'
ln -sfv $DIR/_bashrc            ~/.bashrc
ln -sfv $DIR/_dunstrc           ~/.dunstrc
ln -sfv $DIR/_dvol.sh           ~/.dvol.sh
ln -sfv $DIR/_ghci              ~/.ghci
ln -sfv $DIR/_gitconfig         ~/.gitconfig
ln -sfv $DIR/_inputrc           ~/.inputrc
ln -sfv $DIR/_sensors.sh        ~/.sensors.sh
ln -sfv $DIR/_tmux.conf         ~/.tmux.conf
ln -sfv $DIR/_xmobarrc          ~/.xmobarrc
ln -sfv $DIR/_xprofile          ~/.xprofile
ln -sfv $DIR/_Xresources        ~/.Xresources
ln -sfv $DIR/nixpkgs/config.nix $XDG_CONFIG_HOME/nixpkgs/config.nix
ln -sfv $DIR/nixpkgs/overlays   $XDG_CONFIG_HOME/nixpkgs/overlays
ln -sfv $DIR/nvim/ginit.vim     $XDG_CONFIG_HOME/nvim/ginit.vim
ln -sfv $DIR/nvim/init.vim      $XDG_CONFIG_HOME/nvim/init.vim
ln -sfv $DIR/termite/config     $XDG_CONFIG_HOME/termite/config
ln -sfv $DIR/xmonad/xmonad.hs   ~/.xmonad/xmonad.hs

echo 'installing nvim vim-plug (autoload)'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

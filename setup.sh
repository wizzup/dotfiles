#!/usr/bin/env bash
# create symlinks of configuration files

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR

echo 'creating configuration directories'
mkdir -pv ~/.config/nvim
mkdir -pv ~/.config/termite
mkdir -pv ~/.config/nixpkgs
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
ln -sfv $DIR/nixpkgs/config.nix ~/.config/nixpkgs/config.nix
ln -sfv $DIR/nixpkgs/overlays   ~/.config/nixpkgs/overlays
ln -sfv $DIR/nvim/ginit.vim     ~/.config/nvim/ginit.vim
ln -sfv $DIR/nvim/init.vim      ~/.config/nvim/init.vim
ln -sfv $DIR/termite/config     ~/.config/termite/config
ln -sfv $DIR/xmonad/xmonad.hs   ~/.xmonad/xmonad.hs

echo 'installing nvim vim-plug (autoload)'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

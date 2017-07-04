#!/usr/bin/env bash
# create symlinks of configuration files

PWD=`pwd`

echo $PWD

echo 'creating configuration directories'
mkdir -pv ~/.config/nvim
mkdir -pv ~/.config/termite
mkdir -pv ~/.xmonad

echo 'installing symlinks'
ln -sfv $PWD/bashrc         ~/.bashrc
ln -sfv $PWD/dvol.sh        ~/.dvol.sh
ln -sfv $PWD/ghci           ~/.ghci
ln -sfv $PWD/gitconfig      ~/.gitconfig
ln -sfv $PWD/nvim/init.vim  ~/.config/nvim/init.vim
ln -sfv $PWD/nvim/ginit.vim  ~/.config/nvim/ginit.vim
ln -sfv $PWD/termite/config ~/.config/termite/config
ln -sfv $PWD/tmux.conf      ~/.tmux.conf
ln -sfv $PWD/xmobarrc       ~/.xmobarrc
ln -sfv $PWD/xmonad.hs      ~/.xmonad/xmonad.hs
ln -sfv $PWD/xprofile       ~/.xprofile
ln -sfv $PWD/Xresources     ~/.Xresources
ln -sfv $PWD/inputrc        ~/.inputrc
ln -sfv $PWD/dunstrc        ~/.dunstrc

echo 'installing nvim vim-plug (autoload)'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

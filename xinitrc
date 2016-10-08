#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
# 

## execute system-wide xinitrc first
#if [ -d /etc/X11/xinit/xinitrc.d ]; then
  #for f in /etc/X11/xinit/xinitrc.d/*; do
    #[ -x "$f" ] && . "$f"
  #done
  #unset f
#fi

## grab customized resource
#[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

## system tray
#trayer &
#trayer --edge top --align left --SetDockType true --SetPartialStrut true --expand true --widthtype request --transparent true --alpha 255 --height 12&

# pluse audio system tray
#pasystray &

## dbus notifiacaion
#dunst -config .dunstrc &

## screensaver
#xscreensaver -no-splash &

## composite manager
#xcompmgr -c &

## dropbox
#dropboxd &

## desktop wallpaper
#feh --bg-tile /usr/share/slim/themes/default/background.jpg &

## set the cursoe as pointer, otherwise X will appear as cursor
#xsetroot -cursor_name left_ptr &

## keyboard layout switching
#setxkbmap -layout "us, th" -option "grp:lalt_lshift_toggle" &

## start clipboard manager without icon
#parcellite &

## let me go ahead with pre starting some of the apps
#wine "/home/wisut/.wine/drive_c/Program Files (x86)/MetaTrader 4 - RoboForex/terminal.exe" &
#firefox &
#transmission-gtk -m &
#urxvt &
#chromium &
#bitcoin-qt -min &

# time to start, the master - the window manager xmonad
exec xmonad

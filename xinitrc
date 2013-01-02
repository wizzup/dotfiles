#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# system tray
trayer --edge top --align left --SetDockType true --SetPartialStrut true --expand true --widthtype request --transparent true --alpha 255 --height 12&

# dbus notifiacaion
dunst -config .dunstrc &

# screensaver
# xscreensaver -no-splash &

# composite manager
xcompmgr -c &

# desktop wallpaper
feh --bg-tile /usr/share/slim/themes/default/background.jpg &

# set the cursoe as pointer, otherwise X will appear as cursor
# xsetroot -cursor_name left_ptr &

# keyboard layout switching
setxkbmap -layout "us, th" -option "grp:lalt_lshift_toggle" &

# grab customized resource
# xrdb -merge /home/wisut/.Xresources &
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# start clipboard manager without icon
parcellite &

# let me go ahead with pre starting some of the apps
dropboxd &
# chromium &
# firefox &

# time to start, the master - the window manager xmonad
exec xmonad

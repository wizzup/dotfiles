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
#trayer --align right --SetDockType true --SetPartialStrut true --expand true --widthtype percent --width 5 --transparent true --tint 0x000000 --height 12 &

# screensaver
#xscreensaver -no-splash &

# set the cursoe as pointer, otherwise X will appear as cursor
xsetroot -cursor_name left_ptr

# setup syntaptics for trackpad
synclient MaxTapTime=0
synclient PalmDetect=1

# keyboard layout switching
setxkbmap -layout "us, th" -option "grp:lalt_lshift_toggle"

# grab customized resource
xrdb -merge /home/wisut/.Xresources

# start clipboard manager without icon
parcellite &

# let me go ahead with pre starting some of the apps
dropboxd &
#chromium
#firefox &

# time to start, the master - the window manager xmonad
xmonad

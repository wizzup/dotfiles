#!/bin/bash

## apple_backlight
# /sys/class/backlight/apple_backlight/brightness
# /sys/class/backlight/apple_backlight/max_brightness
# /sys/class/backlight/apple_backlight/actual_brightness

SYSPATH="/sys/class/backlight/apple_backlight/"
SECS="1"

FONT="fixed"
BG="grey"
FG="black"
XPOS="550"
YPOS="400"
WIDTH="205"

#Probably do not customize
PIPE="/tmp/dbright"

err() {
  echo "$1"
  exit 1
}

usage() {
  echo "usage: dbright [option] [argument]"
  echo
  echo "Options:"
  echo "     -i, --increase - increase brightness by \`argument'"
  echo "     -d, --decrease - decrease brightness by \`argument'"
  echo "     -h, --help     - display this"
  exit
}

#Actual brightness changing (readability low)
ACTBRHT="$(cat $SYSPATH/actual_brightness)"
MAXBRHT="$(cat $SYSPATH/max_brightness)"
MAXBRHT="$(cat $SYSPATH/brightness)"

#Argument Parsing
case "$1" in
  '-i'|'--increase')
    echo $ACTBRHT | awk '{printf "%d",$0+1}' > $SYSPATH/brightness
    ;;
  '-d'|'--decrease')
    echo $ACTBRHT | awk '{printf "%d",$0-1}' > $SYSPATH/brightness
    ;;
  ''|'-h'|'--help')
    usage
    ;;
  *)
    err "Unrecognized option \`$1', see dbright --help"
    ;;
esac

#Using named pipe to determine whether previous call still exists
#Also prevents multiple volume bar instances
if [ ! -e "$PIPE" ]; then
  mkfifo "$PIPE"
  (dzen2 -l 1 -x "$XPOS" -y "$YPOS" -w "$WIDTH" -fn "$FONT" -bg "$BG" -fg "$FG" -e 'onstart=uncollapse' < "$PIPE" 
   rm -f "$PIPE") &
fi

#Feed the pipe!
(echo "Brightness $ACTBRHT/$MAXBRHT" ; echo $ACTBRHT | awk '{printf "%2d\n",($0/15)*100}' | dbar ; sleep "$SECS") > "$PIPE"
# (echo "Brightness" ; echo $ACTBRHT | awk '{printf "%2d\n",($0/15)*100}' | dbar ; sleep "$SECS") > "$PIPE"

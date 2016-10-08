#!/bin/sh
xrandr --output VGA-0 --mode 1600x900 --primary --left-of DVI-I-1 \
       --output DVI-I-1 --mode 1440x900 \
       --verbose > .dualscreen_layout.log

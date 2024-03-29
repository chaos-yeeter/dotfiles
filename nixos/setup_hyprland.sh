#!/usr/bin/env bash

# start notification daemon
dunst &

# start bluetooth applet
blueman-applet &

# start network applet
nm-applet --show-indicator &

# start top bar
waybar &

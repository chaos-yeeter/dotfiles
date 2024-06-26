#!/usr/bin/env bash

# start polkit agent
lxqt-policykit-agent &

# start notification daemon
dunst &

# start bluetooth applet
blueman-applet &

# start network applet
nm-applet --show-indicator &

# start easy effects service
easyeffects --gapplication-service &

# start top bar
waybar &

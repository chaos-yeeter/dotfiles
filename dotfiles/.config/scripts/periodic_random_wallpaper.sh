#!/usr/bin/env bash

# wait till hyprpaper starts
while [[ -z "$(pgrep hyprpaper | tr -d '[:space:]')" ]] || (hyprctl hyprpaper listloaded 2>&1 | grep -q "Couldn't connect to"); do
    echo "waiting for hyprpaper to start"
    sleep 1
done

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"

while true; do
    current_wallpaper=$(hyprctl hyprpaper listloaded)
    # get random wallpaper & set it
    new_wallpaper=$(find -L "$WALLPAPER_DIR" -type f | grep -v "$current_wallpaper" | shuf -n 1)
    if [ -z "$new_wallpaper" ]; then
        new_wallpaper="$current_wallpaper"
    fi
    hyprctl hyprpaper reload ,"$new_wallpaper"
    hyprctl hyprpaper unload all
    sleep 30m
done

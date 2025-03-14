#!/usr/bin/env bash

# wait till hyprpaper is initialized
while (hyprctl hyprpaper listloaded 2>&1 | grep -q "^Couldn't connect to"); do
    echo "waiting for hyprpaper to start"
    sleep 1
done

WALLPAPER_DIR="$HOME/wallpapers/"
CURRENT_WALLPAPER=$(hyprctl hyprpaper listloaded)

# get random wallpaper & set it
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALLPAPER")" | shuf -n 1)
hyprctl hyprpaper reload ,"$WALLPAPER"

. $HOME/.bashrc

# start hyprland if it is not running
if [[ "$(hyprctl instances | grep '^instance' | wc -l)" == "0" ]]; then
    Hyprland &
fi

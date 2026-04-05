. $HOME/.bashrc

# gnome dark theme
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

# start niri if it is not running
if ! pgrep -f 'niri' &>/dev/null; then
    niri-session
fi

# setup environment variables
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
export XDG_CONFIG_HOME="$HOME/.config";
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/screenshots";
export XDG_STATE_HOME="$HOME/.local/state";
export QT_QPA_PLATFORMTHEME="qt5ct";
export EDITOR="$(which nvim)"

# setup tools
eval "$(starship init bash)"
eval "$(zoxide init bash --hook pwd --cmd j)"

# make directory & cd into it
mkcd() {
    mkdir -p "$1"
    j "$1"
}

source ~/.config/scripts/tmuxer.sh

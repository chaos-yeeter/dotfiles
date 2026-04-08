# preserve multiline commands in history & reverse search
shopt -s histappend cmdhist lithist
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a; history -r'

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
export PATH="$HOME/.local/bin/:$PATH" # setup for uv

# make directory & cd into it
mkcd() {
    mkdir -p "$1"
    j "$1"
}

source ~/.config/scripts/tmuxer.sh

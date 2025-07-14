export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
export XDG_CONFIG_HOME="$HOME/.config";
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/screenshots";
export XDG_STATE_HOME="$HOME/.local/state";
export QT_QPA_PLATFORMTHEME="qt5ct";
export EDITOR="$(which nvim)"

# setup starship
eval "$(starship init bash)"

# make directory & cd into it
mkcd() {
    mkdir -p "$1"
    j "$1"
}

tmuxer() {
    # get currently running sessions
    local sessions="$(tmux ls -F '#S' 2>/dev/null)"

    # exlude active session
    local active_session=""
    if [[ -n "$TMUX" ]]; then
        active_session="$(tmux display-message -p '#S' 2>/dev/null)"
        sessions=$(printf "$sessions" | grep -v "^$active_session$")
    fi

    # show prompt to search sessions
    local session_name=$(
        printf "$sessions" \
            | fzf --prompt "create/switch session> " --print-query \
            | tail -n 1
    )

    # stop if session_name is empty or if active session is selected
    if [[ -z "$session_name" ]] || [[ "$session_name" == "$active_session" ]]; then
        return
    fi

    # create new session when session_name is not one of existing sessions
    if [[ -z $(printf "$sessions" | grep "^$session_name\$") ]]; then
        tmux new -ds "$session_name"

        # if a directory matches with session name, switch to it
        if [[ -n "$(zoxide query "$session_name" 2>/dev/null)" ]]; then
            tmux send-keys -t "$session_name:0" "j $session_name && clear"
            tmux send-keys -t "$session_name:0" "Enter"
        fi
    fi

    # switch session if inside tmux, otherwise attach to the session
    if [[ -n "$active_session" ]]; then
        tmux switch -t "$session_name"
    else
        tmux at -t "$session_name"
    fi
}

# setup zoxide
eval "$(zoxide init bash --hook pwd --cmd j)"

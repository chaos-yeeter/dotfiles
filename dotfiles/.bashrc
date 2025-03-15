export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

# setup starship
eval "$(starship init bash)"

# make directory & cd into it
mkcd() {
    mkdir -p "$1"
    j "$1"
}

_is_running_in_tmux() {
    if [[ -n "$TMUX" ]]; then
        return 0 # true
    fi
    return 1 # false
}

tmuxer() {
    # get currently running sessions
    local sessions=$(
        tmux ls -F \#S 2>&1 \
            | grep -v '^no server running on'
    )

    # if tmux is already running, exclude attached session
    if _is_running_in_tmux; then
        sessions=$(
            printf "$sessions" \
                | grep -v "^$(tmux display-message -p '#S')$"
        )
    fi

    # show prompt to search sessions
    local session_name=$(
        printf "$sessions" \
            | fzf --prompt "create/switch session> " --print-query \
            | tail -n 1
    )

    # stop if session_name is empty
    if [[ "$session_name" == "" ]]; then
        return
    fi

    # stop if active session is selected
    if _is_running_in_tmux && [[ "$session_name" == "$(tmux display-message -p '#S')" ]]; then
        return
    fi

    # create new session when session_name is not one of existing sessions
    if [[ $(printf "$sessions" | grep "^$session_name\$") == "" ]]; then
        tmux new -ds "$session_name"

        # if a directory matches with session name, switch to it
        local directory=$(
            zoxide query "$session_name" 2>&1 \
                | grep -v "zoxide: no match found"
        )
        if [[ "$directory" != "" ]]; then
            tmux send-keys -t "$session_name:0" "j $directory && clear" Enter
        fi
    fi

    # switch session if inside tmux, otherwise attach to the session
    if _is_running_in_tmux; then
        tmux switch -t "$session_name"
    else
        tmux at -t "$session_name"
    fi
}

# setup zoxide
eval "$(zoxide init bash --hook pwd --cmd j)"

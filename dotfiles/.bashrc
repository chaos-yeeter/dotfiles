export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

# setup zoxide
eval "$(zoxide init bash --hook pwd --cmd j)"

# setup starship
eval "$(starship init bash)"

# make directory & cd into it
mkcd() {
    mkdir -p "$1"
    j "$1"
}

tmuxer() {
    local sessions=$(
        tmux ls -F \#S 2>&1 \
        | grep -v '^no server running on'
    )
    if [[ "$TERM_PROGRAM" == "tmux" ]]; then
        sessions=$(
            printf "$sessions" \
            | grep -v "^$(tmux display-message -p '#S')$"
        )
    fi
        
    local session_name=$(
        printf "$sessions" \
        | fzf --prompt "create/switch session> " --print-query \
        | tail -n 1
    )

    if [[ "$session_name" != "" ]]; then
        if [[ $(printf "$sessions" | grep "^$session_name$") == "" ]]; then
            tmux new -ds "$session_name"
        fi

        if [[ "$TERM_PROGRAM" == "tmux" ]]; then
            tmux switch -t "$session_name"
        else
            tmux at -t "$session_name"
        fi
    fi
}

set -o vi

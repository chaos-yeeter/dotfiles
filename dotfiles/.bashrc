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
    local active_session_directory=$(
        [[ -n "$TMUX" ]] && tmux display-message -t :0 -p '#{pane_current_path}' 2>/dev/null \
        || printf ""
    )

    # list all valid project & running session directories
    local session_directories=$(tmux list-sessions -F '[#S] #{pane_current_path}' 2>/dev/null)
    local project_directories="$(
        find ~/projects/ \
            -maxdepth 4 \
            -type d \
            -name '*pyproject.toml' \
            -o -name '*Makefile' \
            -o -name '*CMakeLists.txt' \
        | xargs -n1 dirname \
        | uniq
    )"

    local search_list=$(
        awk '
            FNR == NR {
                key = $2
                gsub(/[\[\]]/, "", key)
                sessions[key] = $0
                next
            }

            {
                if ($0 in sessions) {
                    print(sessions[$0])
                    delete sessions[$0]
                } else {
                    print($0)
                }
            }

            END {
                for (session in sessions) {
                    print(sessions[session])
                }
            }
            ' <(echo "$session_directories") <(echo "$project_directories") \
        | sort -u
    )

    if [[ -n "$active_session_directory" ]]; then
        search_list=$(echo "$search_list" | grep -v "$active_session_directory")
    fi

    local selected_session_directory=$(
        printf "$search_list" \
        | fzf --prompt 'search project> ' --print-query \
        | tail -n1
    )
    if [[ -z "$selected_session_directory" ]]; then
        return
    fi

    # create session for selected directory & switch to it
    local selected_session_name="$(basename $selected_session_directory | tr -d '[]')"
    tmux new-session -d -s "$selected_session_name" -c "$selected_session_directory" 2>/dev/null
    if [[ -n "$active_session_directory" ]]; then
        tmux switch -t "$selected_session_name"
    else
        tmux attach -t "$selected_session_name"
    fi
}

# setup zoxide
eval "$(zoxide init bash --hook pwd --cmd j)"

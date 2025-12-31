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

    # list all valid project paths including existing tmux sessions
    local search_list=$(
        awk '
            FNR == NR {
                # remove leading [session] to get path instead of $2 to handle spaces in path
                sessions[gensub(/^\[.*\][[:space:]]/, "", "g", $0)] = $0
                next
            }

            {
                print(($0 in sessions) ? sessions[$0] : $0)
                delete sessions[$0]
            }

            END {
                for (session in sessions) {
                    print(sessions[session])
                }
            }
            ' \
            <(tmux list-sessions -F '[#S] #{session_path}' 2>/dev/null) \
            <(
                rg ~/projects/ \
                    --max-depth 4 \
                    --files \
                    --glob '*{pyproject.toml,Makefile,CMakeLists.txt}' \
                | while read -r line; do dirname "$line"; done \
                | sort -u
            ) \
        | sort -rk 2
    )

    if [[ -n "$active_session_directory" ]]; then
        search_list=$(echo "$search_list" | grep -v "$active_session_directory$")
    fi

    local session_directory=$(
        printf "$search_list" \
        | fzf --prompt 'search project> ' --print-query \
        | tail -n1
    )
    if [[ -z "$session_directory" ]]; then
        return
    fi

    local session_name
    if [[ "$session_directory" =~ ^\[(.+)\][[:space:]](.+)$ ]]; then
        session_name="${BASH_REMATCH[1]}"
        session_directory="${BASH_REMATCH[2]}"
    elif [[ -e "$session_directory" ]]; then
        session_name=$(basename "$session_directory")
    else
        session_name="$session_directory"
        session_directory="$HOME"
    fi

    # create session for selected directory & switch to it
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        tmux new-session -d -s "$session_name" -c "$session_directory"
    fi
    if [[ -n "$active_session_directory" ]]; then
        tmux switch -t "$session_name"
    else
        tmux attach -t "$session_name"
    fi
}

# setup zoxide
eval "$(zoxide init bash --hook pwd --cmd j)"

volume_notification_id=12346
volume_limit="1.50" # 150%

toggle_mute() {
    local action="${1:-toggle}"
    wpctl set-mute @DEFAULT_AUDIO_SINK@ "$action"
    if [ "$action" == "1" ] || [ "$action" == "toggle" ]; then
        dunstify --close "$volume_notification_id" &
    fi
}

_get_current_volume() {
    printf "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2)"
}

increase_volume() {
    toggle_mute 0 # unmute

    local amount="${1:-1}"
    wpctl set-volume -l "$volume_limit" @DEFAULT_AUDIO_SINK@ "${amount}%+"

    local current_volume="$(_get_current_volume)"
    if [ "$current_volume" == "$volume_limit" ]; then
        local current_volume_percentage="$(awk -v var=$current_volume 'BEGIN { print (var * 100) }')"
        dunstify --replace "$volume_notification_id" "Volume full" "Level: ${current_volume_percentage}%" &
    else
        dunstify --close "$volume_notification_id" &
    fi
}

decrease_volume() {
    toggle_mute 0 # unmute

    local amount="${1:-1}"
    wpctl set-volume -l "$volume_limit" @DEFAULT_AUDIO_SINK@ "${amount}%-"

    local current_volume="$(_get_current_volume)"
    if [ "$current_volume" == "0.00" ]; then
        local current_volume_percentage="$(awk -v var=$current_volume 'BEGIN { print (var * 100) }')"
        dunstify --replace "$volume_notification_id" "Volume 0%" &
    else
        dunstify --close "$volume_notification_id" &
    fi

}

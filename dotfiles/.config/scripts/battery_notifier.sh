#!/usr/bin/env bash

battery_device="$(find /sys/class/power_supply/ -maxdepth 1 -name "*BAT*" | tail -n 1)"
notification_id=0
while true; do
    battery_level="$(cat ${battery_device}/capacity)"
    charging_status="$(cat ${battery_device}/status)"

    if [ "$charging_status" == "Discharging" ] && [ "$battery_level" -le 15 ]; then
        notification_id=$(dunstify --urgency "critical" "Battery low" "Level: ${battery_level}%" --printid);
    elif [ "$charging_status" == "Charging" ] && [ "$battery_level" -eq 100 ]; then
        notification_id=$(dunstify --urgency "critical" "Battery full" --printid);
    else
        dunstify --close "$notification_id";
    fi

    sleep 1;
done

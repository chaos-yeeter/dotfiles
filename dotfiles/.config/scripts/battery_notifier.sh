#!/usr/bin/env bash

notification_id=12345
battery_device="$(find /sys/class/power_supply/ -maxdepth 1 -name "*BAT*" | tail -n 1)"
while true; do
    battery_level="$(cat ${battery_device}/capacity)"
    charging_status="$(cat ${battery_device}/status)"

    if [ "$charging_status" == "Discharging" ]; then
        if [ "$battery_level" -le 15 ]; then
            dunstify --urgency "critical" --replace "$notification_id" "Battery low" "Level: ${battery_level}";
        else
            dunstify --close "$notification_id";
        fi
    else
        if [ "$battery_level" -eq 100 ]; then
            dunstify --urgency "critical" --replace "$notification_id" "Battery full";
        else
            dunstify --close "$notification_id";
        fi
    fi

    sleep 1;
done

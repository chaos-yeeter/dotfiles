#!/usr/bin/env bash

shopt -s extglob

battery_device="$(find /sys/class/power_supply/ -maxdepth 1 -name "*BAT*" | tail -n 1)"
notification_id=0
notification_active=0
while true; do
    battery_level="$(cat ${battery_device}/capacity)"
    charging_status="$(cat ${battery_device}/status)"

    case "$battery_level:$charging_status" in

        # battery full
        '100:Charging')
            if [ "$notification_active" -eq 0 ]; then
                notification_id=$(dunstify --urgency "critical" "Battery full" --printid);
                notification_active=1;
            fi
            ;;

        # <0 to 15>:<Discharging/Not charging>
        @([0-9]|1[0-5]):@(Discharging|Not\ charging))
            if [ "$notification_active" -eq 0 ]; then
                notification_id=$(dunstify --urgency "critical" "Battery low" --printid);
                notification_active=1;
            fi
            ;;

        *)
            [ "$notification_id" -ne 0 ] && dunstify --close "$notification_id";
            notification_active=0;
            ;;

    esac

    sleep 1;
done

#!/bin/bash

if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
    battery_path="/sys/class/power_supply/BAT0"
elif [[ -f /sys/class/power_supply/BAT1/capacity ]]; then
    battery_path="/sys/class/power_supply/BAT1"
else
    exit 0
fi

last_level=$(cat "$battery_path/capacity")

while true; do
    battery=$(cat "$battery_path/capacity")
    status=$(cat "$battery_path/status")

    if [[ "$status" == "Discharging" ]]; then

        if (( battery <= 20 && last_level > 20 )); then
            notify-send -u critical -t 5000 \
                "Low Battery" \
                "Battery is at ${battery}%"
        fi

        if (( battery <= 10 && last_level > 10 )); then
            notify-send -u critical -t 5000 \
                "Very Low Battery" \
                "Battery is at ${battery}%"
        fi

        if (( battery <= 5 && last_level > 5 )); then
            notify-send -u critical -t 5000 \
                "Critical Battery" \
                "Battery is at ${battery}%. System may shut down soon."
        fi
    fi

    if (( battery == 100 && last_level < 100 )); then
        notify-send -t 5000 \
            "Battery Full" \
            "Battery is fully charged"
    fi

    last_level=$battery

    sleep 30
done

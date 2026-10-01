#!/bin/bash

if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
    battery_path="/sys/class/power_supply/BAT0"
elif [[ -f /sys/class/power_supply/BAT1/capacity ]]; then
    battery_path="/sys/class/power_supply/BAT1"
else
    exit 0
fi

last_level=$(cat "$battery_path/capacity")
last_ac=$(cat /sys/class/power_supply/ACAD/online)

while true; do
    battery=$(cat "$battery_path/capacity")
    status=$(cat "$battery_path/status")
    ac=$(cat /sys/class/power_supply/ACAD/online)

    if [[ "$ac" != "$last_ac" ]]; then
        if [[ "$ac" == "1" ]]; then
            notify-send -t 3000 \
                "Charger Connected" \
                "Power adapter plugged in"
            paplay /usr/share/sounds/freedesktop/stereo/power-plug.oga
        else
            notify-send -t 3000 \
                "Charger Disconnected" \
                "Power adapter unplugged"
            paplay /usr/share/sounds/freedesktop/stereo/power-unplug.oga
        fi
    fi

    if [[ "$status" == "Discharging" ]]; then

        if (( battery <= 20 && last_level > 20 )); then
            notify-send -u critical -t 5000 \
                "Low Battery" \
                "Battery is at ${battery}%"
            paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
        fi

        if (( battery <= 10 && last_level > 10 )); then
            notify-send -u critical -t 5000 \
                "Very Low Battery" \
                "Battery is at ${battery}%"
            paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
        fi

        if (( battery <= 5 && last_level > 5 )); then
            notify-send -u critical -t 5000 \
                "Critical Battery" \
                "Battery is at ${battery}%. System may shut down soon."
            paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga
        fi
    fi

    if (( battery == 100 && last_level < 100 )); then
        notify-send -t 5000 \
            "Battery Full" \
            "Battery is fully charged"
        paplay /usr/share/sounds/freedesktop/stereo/complete.oga
    fi

    last_level=$battery
    last_ac=$ac

    sleep 5
done

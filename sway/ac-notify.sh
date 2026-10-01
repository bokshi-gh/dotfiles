#!/bin/bash

ac_path="/sys/class/power_supply/ACAD/online"

[[ -f "$ac_path" ]] || exit 0

last_ac=$(cat "$ac_path")

while true; do
    ac=$(cat "$ac_path")

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

    last_ac="$ac"
    sleep 1
done

#!/bin/bash

last=""

get_wifi() {
    nmcli -t -f TYPE,STATE,CONNECTION device |
        awk -F: '$1 == "wifi" && $2 == "connected" {print $3; exit}'
}

last=$(get_wifi)

nmcli monitor | while read -r _; do
    sleep 1

    current=$(get_wifi)

    if [[ -n "$current" && "$current" != "$last" ]]; then
        notify-send -t 3000 "Wi-Fi Connected" "$current"
        paplay /usr/share/sounds/freedesktop/stereo/message.oga"
        last="$current"

    elif [[ -z "$current" && -n "$last" ]]; then
        notify-send -t 3000 "Wi-Fi Disconnected"
        paplay /usr/share/sounds/freedesktop/stereo/message.oga"
        last=""
    fi
done

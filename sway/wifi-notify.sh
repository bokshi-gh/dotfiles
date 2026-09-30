#!/bin/bash

last=""

while true; do
    current=$(nmcli -t -f DEVICE,TYPE,STATE,CONNECTION device |
        awk -F: '$2 == "wifi" && $3 == "connected" {print $4; exit}')

    if [[ -n "$current" && "$current" != "$last" ]]; then
        notify-send -t 3000 "Wi-Fi Connected" "$current"
    elif [[ -z "$current" && -n "$last" ]]; then
        notify-send -t 3000 "Wi-Fi Disconnected"
    fi

    last="$current"
    sleep 2
done

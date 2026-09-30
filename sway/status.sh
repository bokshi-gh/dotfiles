#!/bin/bash

while true; do
    wifi_ssid=$(nmcli -t -f active,ssid dev wifi | awk -F: '$1 == "yes" {print $2}')
    wifi_signal=$(nmcli -t -f active,signal dev wifi | awk -F: '$1 == "yes" {print $2}')

    if [[ -n "$wifi_ssid" ]]; then
        wifi_text="Wi-Fi: $wifi_ssid (${wifi_signal}%)"
    else
        wifi_text="Wi-Fi: Disconnected"
    fi

    if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"; then
        volume="Muted"
    else
        volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1 {print $5}')
    fi

    if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
        battery_path="/sys/class/power_supply/BAT0"
    elif [[ -f /sys/class/power_supply/BAT1/capacity ]]; then
        battery_path="/sys/class/power_supply/BAT1"
    else
        battery_path=""
    fi

    if [[ -n "$battery_path" ]]; then
        battery=$(cat "$battery_path/capacity")
        status=$(cat "$battery_path/status")

        if [[ -f "$battery_path/energy_now" ]]; then
            now=$(cat "$battery_path/energy_now")
            full=$(cat "$battery_path/energy_full")
            power=$(cat "$battery_path/power_now" 2>/dev/null || echo 0)
        elif [[ -f "$battery_path/charge_now" ]]; then
            now=$(cat "$battery_path/charge_now")
            full=$(cat "$battery_path/charge_full")
            power=$(cat "$battery_path/current_now" 2>/dev/null || echo 0)
        else
            now=0
            full=0
            power=0
        fi

        if [[ "$status" == "Discharging" && "$power" -gt 0 ]]; then
            remaining=$((now * 60 / power))
            hours=$((remaining / 60))
            minutes=$((remaining % 60))
            time_str=$(printf '%02d:%02d' "$hours" "$minutes")
            battery_text="${battery}% BAT (${time_str} remaining)"

        elif [[ "$status" == "Charging" && "$power" -gt 0 ]]; then
            remaining=$(((full - now) * 60 / power))
            hours=$((remaining / 60))
            minutes=$((remaining % 60))
            time_str=$(printf '%02d:%02d' "$hours" "$minutes")
            battery_text="${battery}% CHR (${time_str} until full)"

        elif [[ "$status" == "Full" ]]; then
            battery_text="${battery}% FULL"

        elif [[ "$status" == "Not charging" ]]; then
            battery_text="${battery}% —"

        else
            battery_text="${battery}%"
        fi
    else
        battery_text="N/A"
    fi

    time=$(date '+%Y-%m-%d %H:%M:%S')

    printf '%s | Vol: %s | Bat: %s | %s\n' \
        "$wifi_text" \
        "$volume" \
        "$battery_text" \
        "$time"

    sleep 1
done

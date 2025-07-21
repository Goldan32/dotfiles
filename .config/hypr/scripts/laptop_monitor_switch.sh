#!/bin/zsh

HYPR_CACHE="${HOME}/.cache/hypr"
mkdir -p "$HYPR_CACHE"

STATE="$HYPR_CACHE/laptop_monitor_state"

if [[ ! -f "$STATE" ]] || [[ "$(cat "$STATE")" == "1" ]]; then
    hyprctl keyword monitor "eDP-1, disabled" && \
        echo 0 > "$STATE"
else
    hyprctl keyword monitor "eDP-1, 1920x1200@60.00, 0x0, 1" && \
        echo 1 > "$STATE"
fi


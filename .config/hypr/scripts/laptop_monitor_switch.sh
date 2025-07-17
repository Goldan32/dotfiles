#!/bin/zsh

HYPR_CACHE="${HOME}/.cache/hypr"
mkdir -p "$HYPR_CACHE"

MONITOR_CONF_FILE="$HYPR_CACHE/laptop_monitor.conf"

if [[ ! -s "$MONITOR_CONF_FILE" ]] || [[ ! -f "$MONITOR_CONF_FILE" ]]; then
    echo 'monitor = eDP-1, disabled' > "$MONITOR_CONF_FILE"
else
    rm "$MONITOR_CONF_FILE"
    touch "$MONITOR_CONF_FILE"
fi


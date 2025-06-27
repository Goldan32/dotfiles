#!/bin/bash

# Only do this for work the thinkpad
if [ "$(hostname)" != "ThinkPad" ]; then
    exit 0
fi

# Exit if no external monitor is connected
if ! hyprctl monitors | grep -q "DP-"; then
    exit
fi

# Get the description of the connected monitor
MONITOR_DESCRIPTION=$(hyprctl monitors | grep -i "description:" | cut -d ' ' -f 2-)

# Logic to apply configuration based on monitor description
if echo "$MONITOR_DESCRIPTION" | grep -q "LG Electronics LG ULTRAFINE 312MANJBDX47"; then
    # Office 4K Monitor
    hyprctl keyword monitor "DP-3,3840x2160@60.00,auto-right,1.25"
elif echo "$MONITOR_DESCRIPTION" | grep -q "ASUSTek COMPUTER INC VG27A M3LMQS294636"; then
    # Home 2K Monitor
    hyprctl keyword monitor "DP-3,2560x1440,auto-right,1"
fi

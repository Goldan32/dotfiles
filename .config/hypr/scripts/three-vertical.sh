#!/usr/bin/env bash

set -euo pipefail

WINCOUNT=$(hyprctl clients -j | jq length)
[ "$WINCOUNT" -ne 3 ] && exit 0

WINDOWS=($(hyprctl clients -j | jq -r '.[].address'))

WIDTHS=("33%" "34%" "33%")

for i in 0 1 2; do
    ADDR="${WINDOWS[$i]}"
    W="${WIDTHS[$i]}"

    hyprctl dispatch focuswindow "address:$ADDR" >/dev/null
    #sleep 0.05

    hyprctl dispatch resizeactive exact "$W" 100% >/dev/null
    #sleep 0.05
done

exit 0

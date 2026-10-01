#!/usr/bin/env bash

EXE_DIR="${1:+$1/}"
KITTEN_EXE="${EXE_DIR}kitten"
KITTY_EXE="${EXE_DIR}kitty"

active="$(hyprctl activewindow -j)"

class="$(jq -r '.class // ""' <<< "$active")"
pid="$(jq -r '.pid // 0' <<< "$active")"

if [[ "$class" == "kitty" && "$pid" -gt 0 ]]; then
    socket="unix:@kitty-${pid}"

    if "$KITTEN_EXE" @ --to "$socket" launch \
        --match state:focused \
        --type=os-window \
        --cwd=current >/dev/null 2>&1
    then
        exit 0
    fi
fi

exec "$KITTY_EXE"

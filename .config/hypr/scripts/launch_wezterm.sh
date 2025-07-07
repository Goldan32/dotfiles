#!/bin/bash

ACTIVE_WINDOW_INFO=$(hyprctl activewindow)
WEZTERM_BIN="$HOME/.local/bin/wezterm --config-file $HOME/.config/wezterm/wezterm-hyprland.lua start"

if echo "$ACTIVE_WINDOW_INFO" | grep -qe 'class: .*wezterm.*'; then
    PID="$(echo "$ACTIVE_WINDOW_INFO" | grep "pid:" | awk '{print $2}')"
    CWD="$(pwdx "$PID" | awk '{print $2}')"

    if [ -n "$CWD" ] && [ -d "$CWD" ]; then
        $WEZTERM_BIN --cwd "$CWD"
    else
        $WEZTERM_BIN
    fi
else
    $WEZTERM_BIN
fi

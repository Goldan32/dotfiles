#!/bin/bash

# Get the active window's class using hyprctl's JSON output and jq
ACTIVE_WINDOW_CLASS=$(hyprctl activewindow -j | jq -r '.class')

WEZTERM_BIN="$HOME/.local/bin/wezterm --config-file $HOME/.config/wezterm/wezterm-hyprland.lua"

# Check if the active window is a WezTerm window
if [[ "$ACTIVE_WINDOW_CLASS" =~ "wezterm" ]]; then
    # It's a WezTerm window. Get the CWD of the active pane directly from WezTerm.
    # We ask for JSON output and use jq to find the focused window, then the active tab,
    # then the active pane, and finally extract its CWD.
    CWD_URL=$($WEZTERM_BIN cli list --format json | jq -r '
        .[] |
        select(.is_active) |
        .cwd
    ')

    # The CWD is a URL like "file:///path/to/dir", so we need to clean it.
    # We use printf to handle URL-encoded characters (e.g., %20 for spaces).
    if [[ -n "$CWD_URL" ]]; then
        CWD_CLEAN_PREFIX=$(echo "$CWD_URL" | sed 's|file://||')
        CWD=$(printf '%b' "${CWD_CLEAN_PREFIX//%/\\x}")
    fi

    # Launch new WezTerm in the found CWD, or home dir as a fallback.
    if [[ -n "$CWD" && -d "$CWD" ]]; then
        $WEZTERM_BIN start --cwd "$CWD"
    else
        $WEZTERM_BIN start --cwd "$HOME"
    fi
else
    # Not a WezTerm window, so just launch a new one in the home directory.
    $WEZTERM_BIN start --cwd "$HOME"
fi

#!/usr/bin/env bash

hypridle --config "$HOME/.config/hypr/hypridle.conf" &
idle_pid=$!

cleanup() {
    hyprctl dispatch dpms on
    kill -9 "$idle_pid" 2> /dev/null
    wait "$idle_pid" 2> /dev/null
}

trap cleanup EXIT INT TERM

hyprlock

#!/usr/bin/env bash

if [ ! -d "$HOME/.wallpaper" ]; then
    echo "No ~/.wallpaper directory"
    exit 0
fi

if [ ! -n "$( ls -A "$HOME/.wallpaper" )" ]; then
    echo "~/.wallpaper is empty"
    exit 0
fi

WPP="$HOME/.wallpaper/$(ls -t "$HOME/.wallpaper" | head -n 1)"

swaybg -i "$WPP" -m fill

exit 1


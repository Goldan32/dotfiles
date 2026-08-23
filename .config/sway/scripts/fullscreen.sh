#!/usr/bin/env bash

swaymsg -t subscribe -m '["window"]' | while read -r line; do
    change=$(jq -r '.change' <<< "$line")

    if [ "$change" = "new" ]; then
        con_id=$(jq -r '.container.id' <<< "$line")

        used_workspaces=$(swaymsg -t get_workspaces | jq -r '.[].num' | sort -n)

        candidate=1
        for n in $used_workspaces; do
            [ "$n" -lt 1 ] && continue
            if [ "$n" -eq "$candidate" ]; then
                candidate=$((candidate + 1))
            elif [ "$n" -gt "$candidate" ]; then
                break
            fi
        done

        swaymsg "[con_id=$con_id] move container to workspace number $candidate, workspace number $candidate, fullscreen enable"
    fi
done

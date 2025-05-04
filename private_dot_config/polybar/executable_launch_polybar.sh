#!/bin/bash

if type "xrandr" > /dev/null 2>&1; then
    monitors=$(xrandr --query | grep " connected" | cut -d" " -f1)
    monitor_count=$(echo "$monitors" | wc -l)

    positions=$(xrandr --query | grep " connected" | grep -o "+[0-9]\++[0-9]\+")
    unique_positions=$(echo "$positions" | sort -u | wc -l)

    if [ "$monitor_count" -gt 1 ] && [ "$unique_positions" -eq 1 ]; then
        primary_monitor=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
        if [ -z "$primary_monitor" ]; then
            primary_monitor=$(echo "$monitors" | head -n 1)
        fi
        MONITOR="$primary_monitor" polybar --reload toph &
        echo "Launched Polybar on primary monitor ($primary_monitor) in duplicate mode."
    else
        for m in $monitors; do
            MONITOR="$m" polybar --reload toph &
            echo "Launched Polybar on $m."
        done
    fi
else
    polybar --reload toph &
    echo "Launched Polybar without monitor specification."
fi

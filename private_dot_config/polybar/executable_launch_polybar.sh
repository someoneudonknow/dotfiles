#!/bin/bash

if type "xrandr" > /dev/null 2>&1; then
  # Get list of connected monitors
  monitors=$(xrandr --query | grep " connected" | cut -d" " -f1)
  monitor_count=$(echo "$monitors" | wc -l)

  # Check if screens are duplicated (same position, e.g., +0+0)
  positions=$(xrandr --query | grep " connected" | grep -o "+[0-9]\++[0-9]\+")
  unique_positions=$(echo "$positions" | sort -u | wc -l)

  if [ "$monitor_count" -gt 1 ] && [ "$unique_positions" -eq 1 ]; then
    # Duplicate mode detected: launch Polybar on primary monitor only
    primary_monitor=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
    if [ -z "$primary_monitor" ]; then
      # Fallback to first connected monitor if no primary is set
      primary_monitor=$(echo "$monitors" | head -n 1)
    fi
    MONITOR="$primary_monitor" polybar --reload toph &
  else
    # Extended mode or single monitor: launch Polybar on all monitors
    for m in $monitors; do
      MONITOR="$m" polybar --reload toph &
    done
  fi
else
  # No xrandr, launch Polybar without monitor specification
  polybar --reload toph &
fi

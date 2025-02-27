#!/bin/bash

menu() {
  printf "1. Only Second\n" 
  printf "2. Only Primary\n"
  printf "3. Duplicates"
}

main() {
    choice=$(menu | rofi -dmenu -config ~/.config/rofi/monitor.rasi | cut -d. -f1)

    PRIMARY="eDP-1"
    SECONDARY="HDMI-1-0"
    RESOLUTION="1920x1080"
    RATE="60"

    case $choice in
        1)
            echo "Only Second"
            xrandr --output "$SECONDARY" --mode "$RESOLUTION" --rate "$RATE" --primary --output "$PRIMARY" --off
            ;;
        2) 
            echo "Only Primary"
            xrandr --output "$PRIMARY" --mode "$RESOLUTION" --rate "$RATE" --primary --output "$SECONDARY" --off
            ;;
        3)
            echo "Duplicates"
            xrandr --output "$PRIMARY" --mode "$RESOLUTION" --rate "$RATE" --primary \
                   --output "$SECONDARY" --mode "$RESOLUTION" --rate "$RATE" --same-as "$PRIMARY"
            ;;
        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac
}

main

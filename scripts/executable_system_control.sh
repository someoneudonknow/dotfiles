#!/bin/bash

options=$(printf "  Shutdown\n  Reboot\n  Logout\n  Suspend\n  Lock")

chosen=$(echo "$options" | rofi -dmenu -p "Power Menu" -config ~/.config/rofi/system_control.rasi)

case "$chosen" in
    "  Shutdown") systemctl poweroff ;;
    "  Reboot") systemctl reboot ;;
    "  Logout") i3-msg exit ;;
    "  Suspend") systemctl suspend ;;
    "  Lock") i3lock -c 000000 ;;
esac

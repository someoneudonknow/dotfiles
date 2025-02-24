
#!/bin/bash

options="  Shutdown\n  Reboot\n  Logout\n  Suspend\n  Lock"

chosen=$(echo "$options" | rofi -dmenu -i -p "Power Menu" -theme $ROFI_THEME)

# Perform action based on user choice
case "$chosen" in
    "  Shutdown") systemctl poweroff ;;
    "  Reboot") systemctl reboot ;;
    "  Logout") i3-msg exit ;;
    "  Suspend") systemctl suspend ;;
    "  Lock") i3lock -c 000000 ;;
esac

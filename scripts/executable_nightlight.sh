#!/bin/bash

CHOICE=$(echo -e "Auto\nReset\n2500K\n3000K\n4000K\n5000K" | rofi -dmenu -p "Set Redshift Temperature")

case "$CHOICE" in
    "Auto") redshift -P -t 5000:4000 ;;
    "Reset") redshift -x ;;
    "2500K") redshift -P -O 2500 ;;
    "3000K") redshift -P -O 3000 ;;
    "4000K") redshift -P -O 4000 ;;
    "5000K") redshift -P -O 5000 ;;
    *) exit 1 ;;
esac

#!/bin/bash

CONF_FILE="$HOME/scripts/state/wallpapers/conf"
DEFAULT_WALLPAPER="$HOME/Pictures/wallpapers/high_res_ani/eyes.jpg"

if [ -f "$CONF_FILE" ]; then
    feh --bg-fill "$(cat "$CONF_FILE")"
else
    feh --bg-fill "$DEFAULT_WALLPAPER"
fi

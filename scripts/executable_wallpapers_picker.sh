#!/bin/bash

WALLPAPERS_DIR="$HOME/Pictures/wallpapers"
THUMBNAILS_DIR="$WALLPAPERS_DIR/.thumbnails"
THUMBNAILS_SIZE="200x200"
CONF_DIR="$HOME/scripts/state/wallpapers/conf"


noti() {
    local mess="$1"
    notify-send "$mess"
}

apply_polybar() {
    ~/scripts/pywal_color.sh

    killall polybar

    while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

    ~/.config/polybar/launch_polybar.sh
}

main() {
    if [ ! -d "$WALLPAPERS_DIR" ]; then
        noti "Wallpapers directory not found!"
    fi

    mkdir -p "$THUMBNAILS_DIR"

    mapfile -t WALLPAPERS < <(find "$WALLPAPERS_DIR" -maxdepth 1 -type f  -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))

    if [[ ${#WALLPAPERS[@]} -eq 0 ]]; then
        noti "Error" "No wallpapers found in $WALLPAPER_DIR!"
        exit 1
    fi

    for w in "${WALLPAPERS[@]}"; do
        filename=$(basename "$w")
        thumbnail="$THUMBNAILS_DIR/$filename"

        if [[ ! -f "$thumbnail" ]]; then
            convert "$w" -thumbnail "$THUMBNAILS_SIZE" "$thumbnail"
        fi
    done

    ROFI_INPUT=""
    for w in "${WALLPAPERS[@]}"; do
        filename=$(basename "$w")
        thumbnail="$THUMBNAILS_DIR/$filename"
        ROFI_INPUT+="$filename\0icon\x1f$thumbnail\n"
    done

    SELECTED=$(echo -en "$ROFI_INPUT" | rofi -dmenu -i -p "Select Wallpaper" -config ~/.config/rofi/wallpapers_picker.rasi -show-icons -icon-theme "Papirus")

    [[ -z "$SELECTED" ]] && exit 0

    for wallpaper in "${WALLPAPERS[@]}"; do
        if [[ "$(basename "$wallpaper")" == "$SELECTED" ]]; then
            feh --bg-fill "$wallpaper"

            wal -i "$wallpaper"


            echo "$wallpaper" > "$CONF_DIR"
            noti "Wallpaper Changed" "Set $SELECTED as wallpaper"

            apply_polybar
            exit 0
        fi
    done

    noti "Error" "Selected wallpaper $SELECTED not found!"
    exit 1
}

main

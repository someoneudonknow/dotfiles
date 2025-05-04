#!/bin/bash
output_file="$HOME/.config/polybar/colors.ini"

pywal_colors="$HOME/.cache/wal/colors.sh"

if [[ ! -f "$pywal_colors" ]]; then
    echo "Error: Pywal colors not found at $pywal_colors!"
    exit 1
fi

source "$pywal_colors"

cat << EOF > "$output_file"
[colors]
background = $background
sys = $color6
grey = $color7
green = $color2
active = $color1
volume_low = $color4
offstate = $color1
foreground = $foreground
EOF

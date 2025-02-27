#!/bin/bash

BRIGHTNESS_VALUE=$(brightnessctl | grep -o "(.*" | tr -d "()")
BRIGHTNESS_NR=${BRIGHTNESS_VALUE//%}

if [ "$BRIGHTNESS_NR" -lt 20 ]; then
    BRIGHTNESS_ICON='󰃞 '
elif [ "$BRIGHTNESS_NR" -lt 50 ]; then
    BRIGHTNESS_ICON='󰃝 ' 
elif [ "$BRIGHTNESS_NR" -lt 80 ]; then
    BRIGHTNESS_ICON='󰃟 ' 
else
    BRIGHTNESS_ICON='󰃠 ' 
fi

ICON_COLOR="%{F#ff7043}" 
TEXT_COLOR="%{F#ffffff}" 
RESET="%{F-}"            

echo "$ICON_COLOR$BRIGHTNESS_ICON$RESET $TEXT_COLOR$BRIGHTNESS_VALUE$RESET"

#!/bin/bash

CURRENT_TIME=$(date +"%H:%M")

CPU_VAL=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')
CPU_ICON="" 

RAM_VAL=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100.0}')
RAM_ICON="" 

BAT_VAL=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n 1)
if [ -z "$BAT_VAL" ]; then
    BAT_VAL="100"
    BAT_ICON="" 
else
    BAT_ICON=""
fi
rofi -show drun \
     -theme ~/.config/rofi/config.rasi \
     -theme-str "textbox-time { content: \"$CURRENT_TIME\"; }" \
     -theme-str "textbox-cpu { content: \"$CPU_ICON\n$CPU_VAL%\"; }" \
     -theme-str "textbox-ram { content: \"$RAM_ICON\n$RAM_VAL%\"; }" \
     -theme-str "textbox-bat { content: \"$BAT_ICON\n$BAT_VAL%\"; }"

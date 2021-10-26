#!/bin/bash 
DATE="$(date +"%I:%M%p %a %b %d")" 
BATTERY="$(cat /sys/class/power_supply/BAT0/capacity)"
STATUS=$?
ICON="dialog-information"

if [ $STATUS -ne 0 ]; then
    MESSAGE="Error Occurred! [ $DATE ]" 
    ICON="dialog-error"
else
    MESSAGE="$Date" 
fi
notify-send -t 6000 -i "$ICON" "$DATE" "Battery $BATTERY%"

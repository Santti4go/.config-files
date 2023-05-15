#!/bin/bash

# Define the calculation to be performed
CALC=$(rofi -dmenu -p "Calculate")

#while true; do
#	text=$(xdotool getwindowfocus getwindowname | sed 's/.<span.>//;s/<\/span>.*//')
#    if [ "$text" != "$last_text" ]; then
#        last_text="$text"
#        echo "$text"
#    fi
#    sleep 0.1
#done

# Perform the calculation and display the result
RESULT=$(echo "$CALC" | bc -l)
rofi -e "$RESULT"

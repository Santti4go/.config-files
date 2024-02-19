#!/bin/sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -x "polybar" >/dev/null; do sleep 1; done

## Launch for each monitor

#if type "xrandr"; then
for monit in $(xrandr --query | grep " connected" | cut -d " " -f1);do

# Left bar
# MONITOR=$monit polybar --reload my-name -c ~/.config/polybar/current.ini &
# MONITOR=$monit polybar --reload date -c ~/.config/polybar/current.ini &

## Center bar
# MONITOR=$monit polybar --reload primary -c ~/.config/polybar/current.ini &

# Spotify
# MONITOR=$monit polybar --reload spotify -c ~/.config/polybar/current.ini &

# MONITOR=$monit polybar -q left-bar -c ~/.config/polybar/current.ini &

## Right bar
# MONITOR=$monit polybar --reload top -c ~/.config/polybar/current.ini &
MONITOR=$monit polybar -q right-bar -c ~/.config/polybar/current.ini &

# MONITOR=$monit polybar --reload level -c ~/.config/polybar/current.ini &

# # My calendar
# MONITOR=$monit polybar --reload calendar -c ~/.config/polybar/current.ini &


done

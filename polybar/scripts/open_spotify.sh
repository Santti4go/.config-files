#!/usr/bin/env bash

spotify_status=$(playerctl --player=spotify status 2>/dev/null)
is_running=$?
if [ $is_running -eq 0 ]; then
    # Already running
    rofi -show window -filter Spotify
else
    # Launch spotify
    rofi -show drun -filter spotify -auto-select 2>/dev/null
fi
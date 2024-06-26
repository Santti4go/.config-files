#!/usr/bin/env bash

# option to skip advertisements
# might be visually disruptive if spotify isn't bound to a currently unused workspace
# switch to 0 to disable skipping
ADSKIP=0

# flag to resume playback after adskip
SKIPPED=0

# read dbus-monitor 
dbus-monitor --profile "interface=org.freedesktop.DBus.Properties,member=PropertiesChanged" | while read -r line; do

    # parse status
    STATUSRAW=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' 2>/dev/null)

    # make sure spotify is running and responding
    if [ "$?" = 0 ]; then
        STATUS=$(echo $STATUSRAW | tail -n 1 | sed 's/.*"\(.*\)".*/\1/g')

        # change toggle icon based on status
        polybar-msg action '#spotify-control.hook.'"$([ $STATUS = 'Playing' ] && echo 0 || echo 1)" </dev/null &>/dev/null

        # parse metadata
        METADATA=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata') 
        ARTIST=$(echo "$METADATA" | grep -A2 "xesam:artist" | tail -n 1 | sed 's/.*"\(.*\)".*/\1/g')
        TITLE=$(echo "$METADATA" | grep -A1 "xesam:title" | tail -n 1 | sed 's/.*"\(.*\)".*/\1/g')

        # shorten displayed title if it's too long (greater than 30 characters)
        if [ ${#TITLE} -gt 30 ]; then
            TITLE=$(echo $TITLE | sed 's/(.*)\|- .*//g')
        fi

        # relaunch if ad playing
        if [ "$ADSKIP" = 1 ] && [[ "$TITLE" = "Advertisement" || "$TITLE" = "Spotify" ]]; then
            pkill spotify
            spotify </dev/null &>/dev/null & disown
            SKIPPED=1

        # polybar output
        else
            echo "$ARTIST - $TITLE"
            if [ "$SKIPPED" = 1 ]; then
                dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
                SKIPPED=0
            fi
        fi
    else
        echo ""
    fi

done

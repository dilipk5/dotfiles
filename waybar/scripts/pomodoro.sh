#!/bin/bash

STATE_FILE="/tmp/pomodoro_state"
FOCUS_TIME=$((25 * 60))
BREAK_TIME=$((5 * 60))

if [ "$1" == "toggle" ]; then
    if pgrep -f 'pomodoro.sh run' > /dev/null; then
        pkill -f 'pomodoro.sh run'
        echo "" > $STATE_FILE
    else
        "$0" run &
    fi
    exit 0
fi

if [ "$1" == "run" ]; then
    mode="focus"
    time_left=$FOCUS_TIME

    while true; do
        echo "$mode $time_left" > $STATE_FILE
        sleep 1
        time_left=$((time_left - 1))

        if [ $time_left -le 0 ]; then
            if [ "$mode" == "focus" ]; then
                mode="break"
                time_left=$BREAK_TIME
            else
                mode="focus"
                time_left=$FOCUS_TIME
            fi
        fi
    done
fi

# Display mode + mm:ss format
if [ -f $STATE_FILE ]; then
    read mode time_left < $STATE_FILE
    [ -z "$time_left" ] && exit 0
    mins=$((time_left/60))
    secs=$((time_left%60))
    printf "%s %02d:%02d" "$mode" "$mins" "$secs"
fi

#!/bin/bash
set -e

/dockerstartup/vnc_startup.sh /dockerstartup/kasm_startup.sh --wait &
startup_pid=$!

for attempt in $(seq 1 30); do
    if DISPLAY=:1 xdpyinfo >/dev/null 2>&1; then
        DISPLAY=:1 xfwm4 --replace >/tmp/xfwm4.log 2>&1 &
        for window_attempt in $(seq 1 30); do
            if DISPLAY=:1 wmctrl -l | grep -qi 'Google Chrome'; then
                DISPLAY=:1 wmctrl -r 'Google Chrome' -b add,maximized_vert,maximized_horz
                break
            fi
            sleep 1
        done
        break
    fi
    sleep 1
done

wait "$startup_pid"

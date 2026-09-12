#!/usr/bin/env bash

set -euo pipefail

/dockerstartup/kasm_default_profile.sh /dockerstartup/vnc_startup.sh /dockerstartup/kasm_startup.sh "$@" &
startup_pid=$!

for attempt in $(seq 1 60); do
    if pgrep -x xfce4-session >/dev/null && DISPLAY=:1 xdpyinfo >/dev/null 2>&1; then
        sleep 5
        DISPLAY=:1 google-chrome --start-maximized --no-first-run --disable-session-crashed-bubble \
            >/tmp/google-chrome.log 2>&1 &
        break
    fi
    sleep 1
done

wait "$startup_pid"

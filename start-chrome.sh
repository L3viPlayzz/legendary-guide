#!/usr/bin/env bash

set -euo pipefail

for attempt in $(seq 1 60); do
    if DISPLAY=:1 xdpyinfo >/dev/null 2>&1; then
        exec google-chrome --start-maximized --no-first-run --disable-session-crashed-bubble
    fi
    sleep 1
done

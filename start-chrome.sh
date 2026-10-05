#!/usr/bin/env bash

set -euo pipefail

profile_dir=/home/kasm-user/chrome-profile

for attempt in $(seq 1 60); do
    if DISPLAY=:1 xdpyinfo >/dev/null 2>&1; then
        lock_file="${profile_dir}/SingletonLock"
        if [[ -L "${lock_file}" ]]; then
            lock_owner="$(readlink "${lock_file}")"
            lock_pid="${lock_owner##*-}"
            lock_host="${lock_owner%-${lock_pid}}"
            if [[ "${lock_host}" != "$(hostname)" ]] || ! kill -0 "${lock_pid}" 2>/dev/null; then
                rm -f "${profile_dir}"/SingletonCookie "${lock_file}" "${profile_dir}"/SingletonSocket
            fi
        fi

        exec env DISPLAY=:1 google-chrome \
            --user-data-dir="${profile_dir}" \
            --start-maximized \
            --no-first-run \
            --disable-session-crashed-bubble
    fi
    sleep 1
done

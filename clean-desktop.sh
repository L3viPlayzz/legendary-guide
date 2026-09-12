#!/usr/bin/env bash

set -euo pipefail

while [[ ! -d /home/kasm-user/Desktop ]]; do
    sleep 1
done

for attempt in $(seq 1 30); do
    if [[ -e /home/kasm-user/Desktop/google-chrome.desktop ]]; then
        break
    fi
    sleep 1
done

rm -f /home/kasm-user/Desktop/com.obsproject.Studio.desktop \
    /home/kasm-user/Desktop/google-chrome.desktop \
    /home/kasm-user/Desktop/gimp.desktop \
    /home/kasm-user/Desktop/nextcloud.desktop \
    /home/kasm-user/Desktop/onlyoffice-desktopeditors.desktop \
    /home/kasm-user/Desktop/org.remmina.Remmina.desktop \
    /home/kasm-user/Desktop/signal-desktop.desktop \
    /home/kasm-user/Desktop/slack.desktop \
    /home/kasm-user/Desktop/sublime_text.desktop \
    /home/kasm-user/Desktop/telegram.desktop \
    /home/kasm-user/Desktop/thunderbird.desktop \
    /home/kasm-user/Desktop/Zoom.desktop

for shortcut in terminal file-manager; do
    source="/usr/share/applications/pulseos-${shortcut}.desktop"
    target="/home/kasm-user/Desktop/pulseos-${shortcut}.desktop"
    if [[ -f "${source}" ]]; then
        cp "${source}" "${target}"
        chmod 755 "${target}"
    fi
done

wallpaper_path="/home/kasm-user/Uploads/image (3).jpg"
if [[ ! -f "${wallpaper_path}" ]]; then
    wallpaper_path=""
fi

if [[ -n "${wallpaper_path}" ]]; then
    for attempt in $(seq 1 30); do
        properties="$(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep '/image-path$' || true)"
        if [[ -n "${properties}" ]]; then
            while IFS= read -r property; do
                xfconf-query -c xfce4-desktop -p "${property}" -s "${wallpaper_path}"
            done <<< "${properties}"
            break
        fi
        sleep 1
    done
fi
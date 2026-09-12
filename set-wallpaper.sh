#!/usr/bin/env bash

set -euo pipefail

wallpaper_path="$(zenity --file-selection \
    --title="Kies een achtergrondafbeelding" \
    --filename="/home/kasm-user/Uploads/" \
    --file-filter="Afbeeldingen | *.png *.jpg *.jpeg *.webp *.bmp" \
    --file-filter="Alle bestanden | *" \
    2>/dev/null)" || exit 0

if [[ -z "${wallpaper_path}" ]]; then
    exit 0
fi

while IFS= read -r property; do
    xfconf-query -c xfce4-desktop -p "${property}" -s "${wallpaper_path}"
done < <(xfconf-query -c xfce4-desktop -l | grep '/image-path$')

zenity --info \
    --title="Achtergrond ingesteld" \
    --text="De gekozen afbeelding is ingesteld als achtergrond." \
    2>/dev/null || true
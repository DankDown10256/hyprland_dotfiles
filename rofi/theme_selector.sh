#!/bin/bash

THEME_STR="window { width: 20%; } listview { lines: 2; }"

# 󱄄 (Gruvbox/Retro) | 󰈊 (Other/Palette)
options="󱄄 Gruvbox\n󰈊 Other\nAkane"

choix=$(echo -e "$options" | rofi -dmenu -i -p "󱥚 Style :" -theme-str "$THEME_STR")

case "$choix" in
    "󱄄 Gruvbox")
        bash "$HOME/.config/rofi/wallpaper_selector_gruvbox.sh" ;;
    "󰈊 Other")
        bash "$HOME/.config/rofi/wallpaper_selector.sh" ;;
    "Akane")
        bash "$HOME/.config/rofi/wallpaper_selector_akane.sh" ;;
    *)
        exit 0 ;;
esac

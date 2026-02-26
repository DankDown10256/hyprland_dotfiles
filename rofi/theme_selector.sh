#!/bin/bash

THEME_STR="window { width: 20%; } listview { lines: 2; }"

options="󱄄 Gruvbox\n󰈊 Other\nAkane\nWallhaven\nOsaka Jade"

choix=$(echo -e "$options" | rofi -dmenu -i -p "󱥚 Style :" -theme-str "$THEME_STR")

case "$choix" in
    "󱄄 Gruvbox")
        bash "$HOME/.config/rofi/wallpaper_selector_gruvbox.sh" ;;
    "󰈊 Other")
        bash "$HOME/.config/rofi/wallpaper_selector.sh" ;;
    "Akane")
        bash "$HOME/.config/rofi/wallpaper_selector_akane.sh" ;;
    "Wallhaven")
        bash "$HOME/.config/rofi/wallpaper_selector_wallhaven.sh" ;;
    "Osaka Jade")
        bash "$HOME/.config/rofi/wallpaper_selector_osaka-jade.sh" ;;
    *)
    exit 0 ;;
esac

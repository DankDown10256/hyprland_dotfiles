#!/bin/bash

THEME_STR="window { width: 20%; } listview { lines: 9; }"

options="󱄄 Gruvbox\n󰈊 Other\nAkane\nEverforest\nMiasma\nAnime\nWallhaven\nArch Riot\nCpUnk\nCyberpunk\nDelorean\nOsaka Jade"

choix=$(echo -e "$options" | rofi -dmenu -i -p "󱥚 Style :" -theme-str "$THEME_STR")

case "$choix" in
    "󱄄 Gruvbox")
        bash "$HOME/.config/rofi/wallpaper_selector_gruvbox.sh" ;;
    "󰈊 Other")
        bash "$HOME/.config/rofi/wallpaper_selector.sh" ;;
    "Akane")
        bash "$HOME/.config/rofi/wallpaper_selector_akane.sh" ;;
    "Everforest")
        bash "$HOME/.config/rofi/wallpaper_selector_everforest.sh" ;;
    "Miasma")
        bash "$HOME/.config/rofi/wallpaper_selector_miasma.sh" ;;
    "Anime")
        bash "$HOME/.config/rofi/wallpaper_selector_anime.sh" ;;
    "Wallhaven")
        bash "$HOME/.config/rofi/wallpaper_selector_wallhaven.sh" ;;
    "Arch Riot")
        bash "$HOME/.config/rofi/wallpaper_selector_archriot.sh" ;;
    "CpUnk")
        bash "$HOME/.config/rofi/wallpaper_selector_cpunk.sh" ;;
    "Cyberpunk")
        bash "$HOME/.config/rofi/wallpaper_selector_cyberpunk.sh" ;;
    "Delorean")
        bash "$HOME/.config/rofi/wallpaper_selector_delorean.sh" ;;
    "Osaka Jade")
        bash "$HOME/.config/rofi/wallpaper_selector_osaka-jade.sh" ;;
    *)
    exit 0 ;;
esac

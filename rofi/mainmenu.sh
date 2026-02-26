#!/bin/bash

# Configuration du look
THEME_STR="window { width: 25%; } listview { lines: 4; }"

# 1. Définir les catégories avec Nerd Fonts
# 󰀻 (Apps) |  (Config) | 󰏘 (Theme)
options="󰀻 Apps\n󰏘 Theme\nProfile Pictures\n Config"

choix=$(echo -e "$options" | rofi -dmenu -i -p "󰣇 System :" -theme-str "$THEME_STR")

case "$choix" in
    "󰀻 Apps")
        rofi -show drun ;;
    "󰏘 Theme")
        bash "$HOME/.config/rofi/theme_selector.sh" ;;
    "Profile Pictures")
        bash "$HOME/.config/rofi/pp-rofi.sh" ;;
    " Config")
        kitty yazi "$HOME/.config" & ;; 
    *)
        exit 0 ;;
esac

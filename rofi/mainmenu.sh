#!/bin/bash

# Configuration du look
THEME_STR="window { width: 25%; } listview { lines: 3; }"

# 1. Définir les catégories avec Nerd Fonts
# 󰀻 (Apps) |  (Config) | 󰏘 (Theme)
options="󰀻 Apps\n Config\n󰏘 Theme"

choix=$(echo -e "$options" | rofi -dmenu -i -p "󰣇 System :" -theme-str "$THEME_STR")

case "$choix" in
    "󰀻 Apps")
        rofi -show drun ;;
    " Config")
        kitty nvim "$HOME/.config" & ;;
    "󰏘 Theme")
        bash "$HOME/.config/rofi/theme_selector.sh" ;;
    *)
        exit 0 ;;
esac

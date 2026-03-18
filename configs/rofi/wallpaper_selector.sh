#!/bin/bash

# Si un argument est passé (appelé depuis theme_selector), on l'utilise
# Sinon on lit le thème sauvegardé
if [[ -n "$1" ]]; then
    THEME_CHOISI="$1"
else
    if [[ ! -f "$HOME/.current_theme" ]]; then
        notify-send "Erreur" "Aucun thème actif. Lance d'abord theme_selector."
        exit 1
    fi
    THEME_CHOISI=$(cat "$HOME/.current_theme")
fi

WALL_DIR="/home/lucas/walls/$THEME_CHOISI"
TARGET_DIR="/home/lucas/current_wallpaper"
TARGET_NAME="background.jpg"

if [ ! -d "$WALL_DIR" ]; then
    notify-send "Erreur" "Le dossier $WALL_DIR est introuvable."
    exit 1
fi

mkdir -p "$TARGET_DIR"

selected_wall=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -printf "%f\0icon\x1f%p\n" | rofi -dmenu -i -p "󰸉 Thème : $THEME_CHOISI" -show-icons)

if [[ -n "$selected_wall" ]]; then
    FULL_PATH="$WALL_DIR/$selected_wall"

    swww img "$FULL_PATH" --transition-type center --transition-step 90
    cp "$FULL_PATH" "$TARGET_DIR/$TARGET_NAME"
    matugen image "$TARGET_DIR/$TARGET_NAME"

    pkill -USR2 waybar
    pkill -USR2 swaync

    notify-send "Wallpaper Updated !" "Style : $THEME_CHOISI" --icon=image-x-generic
else
    exit 0
fi

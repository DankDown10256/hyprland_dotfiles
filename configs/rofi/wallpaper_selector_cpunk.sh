#!/bin/bash

# --- Configuration ---
WALL_DIR="/home/lucas/walls/CpUnk/"
TARGET_DIR="/home/lucas/current_wallpaper"
TARGET_NAME="background.jpg"

# S'assurer que le dossier de destination existe
mkdir -p "$TARGET_DIR"

# --- Rofi Selector ---
# On utilise find pour envoyer le nom du fichier et son icône à Rofi
# Le flag -show-icons permet de voir la preview
selected_wall=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -printf "%f\0icon\x1f%p\n" | rofi -dmenu -i -p "󰸉 All Wallpapers :" -show-icons)

# --- Action ---
if [[ -n "$selected_wall" ]]; then
    FULL_PATH="$WALL_DIR/$selected_wall"

    # 1. Appliquer avec swww (Wayland)
    swww img "$FULL_PATH" --transition-type center --transition-step 90

    # 2. Copier vers le fichier statique background.jpg
    cp "$FULL_PATH" "$TARGET_DIR/$TARGET_NAME"
    matugen image "/home/lucas/current_wallpaper/background.jpg"
    pkill -USR2 waybar
    pkill -USR2 swaync
    
    # 3. Notification optionnelle
    notify-send "Wallpaper Updated !" "Enjoy your new wallpaper" --icon=image-x-generic
else
    echo "Aucune sélection effectuée."
    exit 0
fi

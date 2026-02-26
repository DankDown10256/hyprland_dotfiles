#!/bin/bash

# --- Configuration ---
WALL_DIR="/home/lucas/walls/gruvbox"
TARGET_DIR="/home/lucas/current_wallpaper"
TARGET_NAME="background.jpg"

# S'assurer que le dossier de destination existe
mkdir -p "$TARGET_DIR"

# --- Rofi Selector ---
# On liste le contenu du dossier, on filtre pour ne garder que les images
# -i : ignore la casse | -dmenu : mode liste | -p : prompt personnalisé
selected_wall=$(ls "$WALL_DIR" | rofi -dmenu -i -p "󰸉 Gruvbox Wallpapers :")

# --- Action ---
if [[ -n "$selected_wall" ]]; then
    FULL_PATH="$WALL_DIR/$selected_wall"

    # 1. Appliquer avec swww (Wayland)
    # On ajoute une petite transition sympa pour le style
    swww img "$FULL_PATH" --transition-type center --transition-step 90

    # 2. Copier vers le fichier statique background.jpg
    cp "$FULL_PATH" "$TARGET_DIR/$TARGET_NAME"

    # 3. Notification optionnelle
    notify-send "Wallpaper Updated !" "Enjoy rour new wallpaper" --icon=image-x-generic
else
    echo "Aucune sélection effectuée."
    exit 0
fi

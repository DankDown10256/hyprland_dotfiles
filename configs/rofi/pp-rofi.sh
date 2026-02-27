#!/bin/bash

# --- Configuration ---
PP_DIR="/home/lucas/pfps/"  # Change le chemin vers ton dossier de PP
TARGET_DIR="/home/lucas/.config"
TARGET_NAME="pp.jpg"
THEME_STR="
  window { width: 40%; } 
  listview { columns: 2; lines: 5; } 
  element { orientation: horizontal; } 
  element-icon { size: 64px; }
"

# S'assurer que le dossier existe
list_apps() {
    for file in "$PP_DIR"/*.{png,jpg,jpeg}; do
        [[ -e "$file" ]] || continue
        basename=$(basename "$file")
        # Format spécial Rofi : Texte\0icon\x1fChemin
        echo -en "$basename\0icon\x1f$file\n"
    done
}

# 2. Lancer Rofi avec l'option -show-icons
selected_pp=$(list_apps | rofi -dmenu -i -p "󰇄 Choisir PP :" -show-icons -theme-str "$THEME_STR")

# 3. Action si une image est choisie
if [[ -n "$selected_pp" ]]; then
    FULL_PATH="$PP_DIR/$selected_pp"
    cp "$FULL_PATH" "$TARGET_FILE"
    notify-send "Avatar mis à jour" "Nouvelle PP : $selected_pp" -i "$TARGET_FILE"
fi

#!/bin/bash
THEME_STR="window { width: 20%; } listview { lines: 13; }"
options="󱄄 Gruvbox\n󰈊 Other\nAkane\nE-Ink\nEverforest\nMiasma\nAnime\nWallhaven\nArch Riot\nCpUnk\nCyberpunk\nDelorean\nOsaka Jade"
choix=$(echo -e "$options" | rofi -dmenu -i -p "󱥚 Style :" -theme-str "$THEME_STR")

case "$choix" in
    "󱄄 Gruvbox")  FOLDER="gruvbox" ;;
    "󰈊 Other")     FOLDER="other" ;;
    "Akane")       FOLDER="akane" ;;
    "E-Ink")       FOLDER="eink" ;;
    "Everforest")  FOLDER="everforest" ;;
    "Miasma")      FOLDER="miasma" ;;
    "Anime")       FOLDER="anime" ;;
    "Wallhaven")   FOLDER="wallhaven" ;;
    "Arch Riot")   FOLDER="archriot" ;;
    "CpUnk")       FOLDER="cpunk" ;;
    "Cyberpunk")   FOLDER="cyberpunk" ;;
    "Delorean")    FOLDER="delorean" ;;
    "Osaka Jade")  FOLDER="osaka-jade" ;;
    *)             exit 0 ;;
esac

# Sauvegarder le thème actif
echo "$FOLDER" > "$HOME/.current_theme"

# Appliquer directement le premier wallpaper du dossier
WALL_DIR="$HOME/walls/$FOLDER"
first_wall=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort | head -n 1)

if [[ -z "$first_wall" ]]; then
    notify-send "Erreur" "Aucun wallpaper trouvé dans $WALL_DIR"
    exit 1
fi

TARGET_DIR="$HOME/current_wallpaper"
mkdir -p "$TARGET_DIR"

swww img "$first_wall" --transition-type center --transition-step 90
cp "$first_wall" "$TARGET_DIR/background.jpg"
matugen image "$TARGET_DIR/background.jpg"

pkill -USR2 waybar
pkill -USR2 swaync

notify-send "Thème appliqué !" "Style : $choix" --icon=image-x-generic

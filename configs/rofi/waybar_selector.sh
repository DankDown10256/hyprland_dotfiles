#!/usr/bin/env bash

# Dossier où se trouvent tes configs Waybar
CONFIG_DIR="$HOME/.config/waybar"

# Liste les fichiers commençant par "config" dans le dossier
# Tu peux adapter le filtre selon tes noms de fichiers
selection=$(ls "$CONFIG_DIR" | grep ".jsonc" | rofi -dmenu -p "Sélecteur Waybar" -i)

# Si on a choisi quelque chose
if [ -n "$selection" ]; then
    # On tue l'instance actuelle
    killall waybar
    
    # On lance la nouvelle config en arrière-plan
    # Note : On suppose que le style.css reste le même ou est lié à la config
    waybar -c "$CONFIG_DIR/$selection" &
    
    notify-send "Waybar" "Configuration chargée : $selection"
fi

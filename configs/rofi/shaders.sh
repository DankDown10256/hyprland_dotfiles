#!/usr/bin/env bash

# Dossier des shaders
SHADER_DIR="$HOME/.config/hypr/shaders"
# On récupère le shader actuel
CURRENT_SHADER=$(hyprshade current)

# On liste les fichiers .glsl dans le dossier + l'option pour désactiver
options=$(ls "$SHADER_DIR" | grep ".glsl$" | sed 's/\.glsl//')
options="off\n$options"

# On ajoute un indicateur visuel sur le shader actif
menu_options=""
while read -r line; do
    if [[ "$line" == "$CURRENT_SHADER" ]]; then
        menu_options+="$line *\n"
    else
        menu_options+="$line\n"
    fi
done <<< "$(echo -e "$options")"

# Affichage du menu Rofi
choice=$(echo -e "$menu_options" | rofi -dmenu -i -p "Hyprshade" -config ~/.config/rofi/config.rasi)

# Traitement du choix
if [ -n "$choice" ]; then
    # On nettoie le choix (enlève l'astérisque si présent)
    clean_choice=$(echo "$choice" | sed 's/ \*//')

    if [ "$clean_choice" == "off" ]; then
        hyprshade off
    else
        hyprshade toggle "$clean_choice"
    fi
fi

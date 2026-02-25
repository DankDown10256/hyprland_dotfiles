#!/bin/bash

# Configuration du look (optionnel)
THEME_STR="window { width: 25%; } listview { lines: 4; }"

# 1. Définir les catégories du menu principal
options="🚀 Apps\n⚙️ Config\n🖼 Wallpaper"

# 2. Afficher le menu et récupérer le choix
choix=$(echo -e "$options" | rofi -dmenu -i -p "Menu :" -theme-str "$THEME_STR")

case "$choix" in
    "🚀 Apps")
        # Relance Rofi en mode drun (le mode normal avec icônes)
        rofi -show drun
        ;;

    "⚙️ Config")
        # Lance ton terminal avec Neovim ouvert dans ton dossier de config
        # Remplace 'kitty' par ton terminal (alacritty, foot, etc.)
        kitty nvim "$HOME/.config" &
        ;;

    "🖼 Wallpaper")
        # Appelle le script qu'on a créé précédemment
        bash "$HOME/.config/rofi/wallpaper_selector.sh"
        ;;

    *)
        exit 0
        ;;
esac

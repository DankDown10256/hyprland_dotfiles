#!/bin/bash

# 1. Récupérer l'IP via rofi
# On utilise -p pour le prompt et -dmenu pour le mode entrée de texte
IP=$(echo "" | rofi -dmenu -p "Connexion SSH (lucas@...) :" -theme-str 'entry { placeholder: "Entrez l IP ou le hostname"; }')

# 2. Vérifier si l'utilisateur a annulé (Echap) ou n'a rien entré
if [ -z "$IP" ]; then
    exit 1
fi

# 3. Lancer le terminal avec la commande SSH
# Note : Adapte 'kitty' par ton terminal (alacritty, gnome-terminal, st, etc.)
# Pour la plupart des terminaux, l'option est -e pour exécuter une commande.
kitty ssh "lucas@$IP"

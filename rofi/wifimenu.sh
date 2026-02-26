#!/usr/bin/env bash

# Configuration de Rofi
# Change "style-1.rasi" par ton thème si tu en as un
ROFI_CMD="rofi -dmenu -i -p Wi-Fi -no-custom"

# Récupération de l'état actuel
msg_current() {
    active_ssids=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    if [ -z "$active_ssids" ]; then
        echo "Déconnecté"
    else
        echo "Connecté à : $active_ssids"
    fi
}

# 1. Lister les réseaux disponibles
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/^--/Ouvert/' | awk '{print $2 " (" $1 ")"}' | sort -u)

# 2. Afficher le menu Rofi
chosen_network=$(echo -e "OFF\nRESCAN\n$wifi_list" | $ROFI_CMD -mesg "$(msg_current)")

# Sortie si on appuie sur Echap
if [ -z "$chosen_network" ]; then
    exit
fi

# 3. Actions selon le choix
case $chosen_network in
    "OFF")
        nmcli radio wifi off
        ;;
    "RESCAN")
        nmcli device wifi rescan
        $0 # Relance le script après le scan
        ;;
    *)
        # Extraire le SSID (tout ce qui est avant la parenthèse)
        ssid=$(echo "$chosen_network" | sed 's/ (.*)//')
        
        # Vérifier si on connaît déjà le réseau
        known_networks=$(nmcli -t -f name connection show)
        
        if echo "$known_networks" | grep -qw "$ssid"; then
            nmcli connection up "$ssid"
        else
            # Demander le mot de passe si inconnu
            pass=$(rofi -dmenu -p "Mot de passe pour $ssid" -password)
            if [ -n "$pass" ]; then
                nmcli device wifi connect "$ssid" password "$pass"
            fi
        fi
        ;;
esac

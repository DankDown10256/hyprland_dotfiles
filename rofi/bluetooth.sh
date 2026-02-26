#!/usr/bin/env bash

# Dossier d'icônes ou symboles (optionnel)
POWER_ON="󰂯 On"
POWER_OFF="󰂲 Off"

# Fonction pour obtenir la liste des appareils appairés
get_devices() {
    bluetoothctl devices | cut -d ' ' -f 3-
}

# Menu principal
options="$POWER_ON\n$POWER_OFF\nScan\nConnecter\nDéconnecter"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Bluetooth")

case "$chosen" in
    "$POWER_ON")
        bluetoothctl power on
        ;;
    "$POWER_OFF")
        bluetoothctl power off
        ;;
    "Scan")
        notify-send "Bluetooth" "Scan en cours..."
        bluetoothctl --timeout 10 scan on
        ;;
    "Connecter")
        # Sélection de l'appareil par nom, puis récupération de l'adresse MAC
        device=$(get_devices | rofi -dmenu -i -p "Appareil à connecter")
        if [ -n "$device" ]; then
            mac=$(bluetoothctl devices | grep "$device" | cut -d ' ' -f 2)
            bluetoothctl connect "$mac" && notify-send "Bluetooth" "Connecté à $device"
        fi
        ;;
    "Déconnecter")
        device=$(get_devices | rofi -dmenu -i -p "Appareil à déconnecter")
        if [ -n "$device" ]; then
            mac=$(bluetoothctl devices | grep "$device" | cut -d ' ' -f 2)
            bluetoothctl disconnect "$mac" && notify-send "Bluetooth" "Déconnecté de $device"
        fi
        ;;
esac

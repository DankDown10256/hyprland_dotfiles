#!/usr/bin/env bash

# --- CONFIGURATION ---
BT_SCRIPT="$HOME/.config/rofi/bluetooth.sh"
BT_ICON="󰂯 Gestion Bluetooth"

# --- RÉCUPÉRATION DES SORTIES AUDIO ---
# On récupère la liste des noms des sorties (Sinks) via PulseAudio/Pipewire
sinks=$(pactl list short sinks | awk '{print $2}')

# --- CONSTRUCTION DU MENU ---
# On met le Bluetooth en premier, puis la liste des sorties audio
options="$BT_ICON\n$sinks"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Sortie Audio / Bluetooth")

# --- LOGIQUE DE SÉLECTION ---
if [ "$chosen" = "$BT_ICON" ]; then
    # Si on choisit Bluetooth, on lance ton script
    bash "$BT_SCRIPT"
elif [ -n "$chosen" ]; then
    # Sinon, on définit la sortie audio choisie par défaut
    pactl set-default-sink "$chosen"
    notify-send "Audio" "Sortie changée vers : $chosen"
fi

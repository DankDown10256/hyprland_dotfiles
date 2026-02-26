#!/bin/bash

# 1. Récupérer la liste des sorties (Sinks)
# On extrait l'ID et le nom lisible (Description)
sinks=$(pactl list sinks | grep -E 'Sink #|Description:' | awk -F': ' '{
    if ($1 ~ /Sink #/) {id=$2}
    else {print id " - " $2}
}')

# 2. Afficher le menu Rofi
selected=$(echo "$sinks" | rofi -dmenu -i -p "Sortie Audio" -l 10)

# 3. Extraire l'ID de la sélection
sink_id=$(echo "$selected" | awk '{print $1}')

# 4. Appliquer le changement si une sélection a été faite
if [ -n "$sink_id" ]; then
    pactl set-default-sink "$sink_id"
    notify-send "Audio" "Sortie changée vers : ${selected#* - }" -i audio-speakers
fi

#!/bin/sh

INFO() {
  echo "[INFO] $1"
}

rofi=/home/$USER/.config/rofi/
hypr=/home/$USER/.config/hypr/
swaync=/home/$USER/.config/swaync/
waybar=/home/$USER/.config/waybar/

echo "Update configurations"

cp -r "$rofi" ./configs/rofi/
INFO "Rofi copied"

cp -r "$hypr" ./configs/hypr/
INFO "Hypr copied"

cp -r "$swaync" ./configs/swaync/
INFO "swaync copied"

cp -r "$waybar" ./configs/waybar/
INFO "Waybar copied"

echo "Update finished"

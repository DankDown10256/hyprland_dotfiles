#!/usr/bin/env bash

# Options
shutdown='󰐥 Déconnexion'
reboot='󰜉 Redémarrer'
lock='󰌾 Verrouiller'
suspend='󰤄 Veille'
logout='󰍃 Quitter'
yes='Oui'
no='Non'

# Lancement de Rofi
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu \
		-p "Système" \
		-theme ~/.config/rofi/powermenu.rasi
}

# Logique de sélection
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		systemctl poweroff ;;
    $reboot)
		systemctl reboot ;;
    $lock)
		i3lock ;; # Ou hyprlock / swaylock selon ton setup
    $suspend)
		mpc -q pause
		amixer set Master mute
		systemctl suspend ;;
    $logout)
		loginctl terminate-user $USER ;;
esac

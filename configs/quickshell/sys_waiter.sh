#!/usr/bin/env bash

# Kill any child listening jobs on exit so we don't spawn infinite zombies
trap 'kill $(jobs -p) 2>/dev/null' EXIT

# PulseAudio/PipeWire Audio changes
pactl subscribe 2>/dev/null | grep --line-buffered -E "Event 'change' on sink" | head -n 1 &

# NetworkManager changes
nmcli monitor 2>/dev/null | grep --line-buffered -E "connected|disconnected|unavailable|enabled|disabled" | head -n 1 &

# Bluetooth changes via DBus
dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',arg0='org.bluez.Device1'" 2>/dev/null | grep --line-buffered "interface" | head -n 1 &

# Battery/Power changes via udev
udevadm monitor --subsystem-match=power_supply 2>/dev/null | grep --line-buffered "change" | head -n 1 &

# Hyprland layout changes via your existing socket
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - 2>/dev/null | grep --line-buffered "activelayout" | head -n 1 &

# MPRIS / Playerctl changes via DBus (Session Bus)
dbus-monitor --session "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/org/mpris/MediaPlayer2'" 2>/dev/null | grep --line-buffered "interface" | head -n 1 &

# Failsafe: Force a silent UI refresh every 60 seconds just in case an event is missed
sleep 60 &

# Wait for the *first* background job to complete (i.e. an event occurred)
wait -n

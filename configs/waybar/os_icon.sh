#!/bin/bash

OS_RELEASE="/etc/os-release"

if [ ! -f "$OS_RELEASE" ]; then
  echo ""
  exit 1
fi

source "$OS_RELEASE"

case "$ID" in
"arch"*)
  ICON="" # Arch Linux
  ;;
"manjaro")
  ICON="󱘊" # Manjaro
  ;;
"endeavouros")
  ICON="" # EndeavourOS
  ;;
"artix")
  ICON="" # Artix Linux
  ;;
"garuda")
  ICON="" # Garuda Linux
  ;;
"archlabs")
  ICON="" # ArchLabs Linux
  ;;
*)
  ICON=""
  ;;
esac

echo $ICON


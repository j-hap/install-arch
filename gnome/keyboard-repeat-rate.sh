#! /bin/bash

INTERVAL=20
DELAY=200

if command -v gsettings &>/dev/null; then
  gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval $INTERVAL
  gsettings set org.gnome.desktop.peripherals.keyboard delay $DELAY
elif command -v dconf &>/dev/null; then
  dconf write /org/gnome/desktop/peripherals/keyboard/repeat-interval $INTERVAL
  dconf write /org/gnome/desktop/peripherals/keyboard/delay $DELAY
fi


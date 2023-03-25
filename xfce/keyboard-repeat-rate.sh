#! /bin/bash

DELAY=180 # in ms
RATE=50   # in Hz

if command -v xfconf-query &>/dev/null; then
  xfconf-query --channel keyboards --property /Default/KeyRepeat/Delay --create --type int --set $DELAY
  xfconf-query --channel keyboards --property /Default/KeyRepeat/Rate --create --type int --set $RATE
fi

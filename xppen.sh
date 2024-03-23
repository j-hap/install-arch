#!/usr/bin/env sh

# based on https://gist.github.com/Konfekt/d57567b84b264e37e62bd5c001e76457

usage() {
  cat <<EOF
Usage: $0 <Monitor>

Map all Wacom Devices to Monitor <Monitor>.
For example, to map to Monitor VGA-1:

  $0 VGA-1

If <Monitor> is NEXT, then to the next monitor
as listed by xrandr. Useful, for example, to bind,
say by xbindkeys, a key to

  notify-send "\$(\$0 NEXT)"

EOF
  exit 1
}

next() {
  if [ -z "$TMPDIR" ]; then
    TMPDIR=$(dirname $(mktemp --dry-run))
  fi
  WFILE="$TMPDIR/tablet-map-target"

  # Since
  #   xsetwacom --get "Wacom Pad pad" MapToOutput
  # returns
  #   'MapToOutput' is a write-only option.
  # we store the output device in a temp file.
  # This, woefully, cannot detect output device changes;
  # for example, after a reboot.

  if [ -f "$WFILE" ]; then
    current_monitor="$(cat "$WFILE")"
  else
    current_monitor=""
  fi

  if [ -z current_monitor ]; then
    # no mapping known, just use the first monitor
    next_monitor=$(xrandr --listactivemonitors | sed -n 2p | awk '{print $4}')
  else
    # duplicate the output in case the current monitor is the last one, so we automatically cycle
    # through. head after grep takes the first match and sed afterwards drops the match and keeps
    # only the next monitor
    next_monitor=$(xrandr --listactivemonitors | sed 1d | awk '{print $4}' | tee /dev/stdout | grep -A 1 "$current_monitor" | sed -n 2p)
  fi

  echo "$next_monitor" >$WFILE
  echo "$next_monitor"
}

map_tablet_to_screen() {
  if ! command -v xsetwacom >/dev/null; then
    echo "xsetwacom command not found" >&2
    exit 1
  fi

  if ! command -v xrandr >/dev/null; then
    echo "xrandr command not found" >&2
    exit 1
  fi

  if [[ $# == 0 ]]; then
    usage
  else
    screen="$1"
  fi

  if [ "$screen" = "--next" ]; then
    screen="$(next)"
  fi

  if [ -z "$(xsetwacom --list devices)" ]; then
    echo "No devices found" >&2
    exit 1
  fi

  xsetwacom --list devices | cut -f 1 | xargs -I '{}' xsetwacom --set "{}" MapToOutput "$screen"
  exit 0
}

# creates a config file to that the xp pen tablet can be used with xsetwacom
# see https://forums.linuxmint.com/viewtopic.php?t=390993
# and https://wiki.archlinux.org/title/Graphics_tablet
if [ ! -f /etc/X11/xorg.conf.d/10-xppen.conf ]; then
  sudo dd of="/etc/X11/xorg.conf.d/10-xppen.conf" <<EOF
Section "InputClass"
        Identifier "XP-Pen tablet class"
        MatchUSBID "28bd:*"
        MatchDevicePath "/dev/input/event*"
        MatchIsTablet "true"
        Driver "wacom"
EndSection
EOF
fi

map_tablet_to_screen "$@"

#! /bin/sh

username=$(whoami)
# ^\[Seat/,\$ : operate on lines between the one starting with '[Seat' and the last one
# s : replace
# the line start starts with whitespace and has the 'autologin-user=' key
# with a line that has the just created user name
sudo sed -i "/^\[Seat/,\$s/#\?\s*autologin-user=.*$/autologin-user=$username/" /etc/lightdm/lightdm.conf

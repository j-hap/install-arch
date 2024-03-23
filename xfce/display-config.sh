# this is just a reminder script to configure a dual monitor setup, since the property names of the
# displays depend on the connection method, detection order and some more
profile="Default" # must not contain a forward slash
vertical_offset=453

# position of the left monitor
xfconf-query --channel displays --property "/$profile/DP-3-8/Position/X" --set 0
xfconf-query --channel displays --property "/$profile/DP-3-8/Position/Y" --set 0
# left monitor shall have a 90 degree right rotation
xfconf-query --channel displays --property "/$profile/DP-3-8/Rotation" --create --type int --set 90

# position of the right monitor
left_width=$(xfconf-query --channel displays --property "/$profile/DP-3-8/Resolution" | cut -d "x" -f 2-)
xfconf-query --channel displays --property "/$profile/DP-3-1-8/Position/X" --set "$left_width"
xfconf-query --channel displays --property "/$profile/DP-3-1-8/Position/Y" --set $vertical_offset
xfconf-query --channel displays --property "/$profile/DP-3-1-8/Rotation" --set 0
xfconf-query --channel displays --property "/$profile/DP-3-1-8/Primary" --set true

# these two lines activate all the changes
xfconf-query --channel displays --property /Schemes/Apply --create --type string --set "$profile"
xfconf-query --channel displays --property /Schemes/Apply --reset

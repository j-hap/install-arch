xfconf-query --channel keyboard-layout --property /Default/XkbDisable --create --type bool --set false
xfconf-query --channel keyboard-layout --property /Default/XkbLayout --create --type string --set eu
xfconf-query --channel keyboard-layout --property /Default/XkbVariant --reset
# is this neccessary? how does is work with the xfconf-query settings?
setxkbmap eu

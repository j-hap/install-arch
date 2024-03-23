xfconf-query --channel keyboard-layout --property /Default/XkbDisable --create --type bool --set false
xfconf-query --channel keyboard-layout --property /Default/XkbLayout --create --type string --set us
#xfconf-query --channel keyboard-layout --property /Default/XkbVariant --create --type string --set intl
xfconf-query --channel keyboard-layout --property /Default/XkbVariant --create --type string --set altgr-intl

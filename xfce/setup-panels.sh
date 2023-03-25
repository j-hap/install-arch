# removes all panels to build up from zero
xfconf-query --channel xfce4-panel --property /panels --reset
for property in $(xfconf-query --channel xfce4-panel --property /panels --list | grep --perl-regexp "panel-\d"); do
  xfconf-query --channel xfce4-panel --property $property --reset
done

# restart creates one empty default panel with index 1
xfce4-panel --restart

# using xfce4-panel to add plugins only works because there is only one panel.
# if there were more than one, each call would ask to which panel the plugin
# shall be added
sleep 0.25 # wait for restart to finish
xfce4-panel --add=whiskermenu
xfce4-panel --add=separator

for app in "firefox" "code" "discord"; do
  template="/usr/share/applications/$app.desktop"
  echo $template
  if [ ! -f $template ]; then
    echo "Could not find .desktop file for $app"
  fi
  xfce4-panel --add=launcher $template
done

xfce4-panel --add=separator
xfce4-panel --add=tasklist
# diables grouping on windows panel
plugin=$(xfconf-query --channel xfce4-panel --list --verbose | grep tasklist | cut -d ' ' -f 1)
xfconf-query --channel xfce4-panel --property $plugin/grouping --create --type bool --set false

xfce4-panel --add=separator
# enable stretch
plugin=$(xfconf-query --channel xfce4-panel --list --verbose | grep separator | cut -d ' ' -f 1 | sort | tail -n 1)
xfconf-query --channel xfce4-panel --property $plugin/expand --create --type bool --set true
xfconf-query --channel xfce4-panel --property $plugin/style --create --type int --set 0 # transparent

xfce4-panel --add=systray # discord, nm-applet, etc. icons
xfce4-panel --add=pulseaudio
xfce4-panel --add=clock
xfce4-panel --add=showdesktop

# stretch the new panel over complete width and place on the bottom
xfconf-query --channel xfce4-panel --property /panels/panel-1/size --create --type int --set 24
xfconf-query --channel xfce4-panel --property /panels/panel-1/length --create --type double --set 100
xfconf-query --channel xfce4-panel --property /panels/panel-1/length-adjust --create --type bool --set true
xfconf-query --channel xfce4-panel --property /panels/panel-1/position-locked --create --type bool --set true
# p : position number, see https://git.xfce.org/xfce/xfce4-panel/tree/libxfce4panel/libxfce4panel-enums.h#n80, 8 is south east
xfconf-query --channel xfce4-panel --property /panels/panel-1/position --set "p=8;x=0;y=0"

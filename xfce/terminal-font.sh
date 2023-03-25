xfconf-query --channel xsettings --property /Gtk/MonospaceFontName --create --type string --set "Noto Sans Mono Regular 10"
sed -i 's/FontUseSystem=FALSE/FontUseSystem=TRUE/' ~/.config/xfce4/terminal/terminalrc

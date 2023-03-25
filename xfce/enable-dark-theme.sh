# sets dark theme
xfconf-query --channel xsettings --property /Net/ThemeName --set Adwaita-dark
# synchronizes the xfwm4 theme the the selected theme above (if there is one)
xfconf-query --channel xsettings --property /Xfce/SyncThemes --create --type bool --set true

for p in $(xfconf-query --channel xfce4-desktop --list | grep backdrop); do
  xfconf-query --channel xfce4-desktop --property $p --reset
done

# 1d273aff -> 29 39 58 255 -> 0.114 0.153 0.227 1.0
for display in $(xfconf-query --channel displays --list | grep Default | grep -v _ | cut -d '/' -f 3 | sort | uniq); do
  for i in $(seq 0 $(xfconf-query --channel xfwm4 --property /general/workspace_count)); do
    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor${display}/workspace${i}/color-style --create --type int --set 0
    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor${display}/workspace${i}/image-style --create --type int --set 0
    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor${display}/workspace${i}/rgba1 --create --type double --type double --type double --type double --set 0.114 --set 0.153 --set 0.227 --set 1.0
  done
done

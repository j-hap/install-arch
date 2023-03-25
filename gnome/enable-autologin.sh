#! /bin/bash
user=$(whoami)
filename="/etc/gdm/custom.conf"

if ! grep --quiet "AutomaticLoginEnable=" $filename; then
  sudo sed -i '/\[daemon\]/a AutomaticLoginEnable=True' $filename
else
  # uncomment
  sudo sed -i '/AutomaticLoginEnable=/s/^\s*#?\s*//' $filename
  # set to true
  sudo sed -i 's/AutomaticLoginEnable=.*$/AutomaticLoginEnable=true/' $filename
fi

if ! grep --quiet "AutomaticLogin=" $filename; then
  sudo sed -i "/AutomaticLoginEnable=true/a AutomaticLogin=$user" $filename
else
  # uncomment
  sudo sed -i '/AutomaticLoginEnable=/s/^\s*#?\s*//' $filename
  # set to current user
  sudo sed -i "s/AutomaticLogin=.*$/AutomaticLogin=$user/" $filename
fi

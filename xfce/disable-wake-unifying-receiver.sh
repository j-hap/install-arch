vendor=$(lsusb | grep Logitech | grep "Unifying Receiver" | awk '{print $6}' | cut --delimiter ':' --field 1)
bus=$(lsusb | grep Logitech | grep "Unifying Receiver" | awk '{print $2}')
device=$(lsusb | grep Logitech | grep "Unifying Receiver" | awk '{print $4}')
# remove leading zeros
bus=$(echo $bus | sed 's/^0*//')
device=$(echo $device | sed --expression 's/^0*//' --expression 's/:$//')
if [ -n "$bus" ] && [ -n "$device" ]; then
  echo 'disabled' | sudo tee "/sys/bus/usb/devices/$bus-$device/power/wakeup" >/dev/null
fi

# make it permanent
sudo dd of=/etc/udev/rules.d/logitech.rules <<EOF
ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="$vendor", ATTR{power/wakeup}="disabled"
EOF

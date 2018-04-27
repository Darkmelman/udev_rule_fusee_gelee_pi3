#!/bin/bash
# Create UDEV rule for switch in RCM Mode
# create file fusee.sh

if [ ! -e /home/pi/fusee.sh ]; then
echo "Creating fusee.sh"
cat <<EOF > /home/pi/fusee.sh
#!/bin/bash
sleep 3
sudo python3 /home/pi/fusee-launcher/fusee-launcher.py fusee.bin
EOF
sudo chmod +x /home/pi/fusee.sh
else
    echo "file already exists!"
fi

cat <<EOF > /etc/udev/rules.d/100-switch.rules
# change idVendor and idProduct
# 0955:7321 NVidia Corp.
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0955", ATTR{idProduct}=="7321", RUN+="/home/pi/fusee.sh"
EOF

sudo udevadm control --reload-rules

sudo service udev restart

#tail -f /var/log/syslog


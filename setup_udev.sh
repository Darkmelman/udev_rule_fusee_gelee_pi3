#!/bin/bash
# Create UDEV rule for switch in RCM Mode
# create file fusee.sh
if [ ! -e /home/pi/fusee.sh ]; then
    echo "Creating fusee.sh"
    cat <<EOF > /etc/udev/rules.d/100-switch.rules
    #!/bin/bash
    sleep 3
    sudo python3 /home/pi/fusee-launcher.py fusee.bin
    EOF
else
    echo "file already exists!
fi
cat <<EOF > /etc/udev/rules.d/100-switch.rules
####################################################################################
# change idVendor and idProduct
# lsusb gives for example ID 0424:ec00
# the string befoe the : is the idVendor and after the : idProduct
#
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0424", ATTR{idProduct}=="ec00"
, RUN+="/home/pi/fusee.sh"
#####################################################################################
EOF

sudo service udev restart

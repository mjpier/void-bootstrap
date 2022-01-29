#!/bin/sh
# https://github.com/hoaxdream
# Author: hoaxdream

# Change the value according to your hdd/sdd.
CORE_UUID=$(blkid -s UUID -o value /dev/nvme1n1p1)
DATA_UUID=$(blkid -s UUID -o value /dev/sda1)

makedir() {
    cd /media
    mkdir core data
}

getuuid() {
echo "# /dev/nvme1n1p1
UUID=$CORE_UUID /media/core ext4 rw,user,exec 0 0

# /dev/sda1
UUID=$DATA_UUID /media/data ext4 rw,user,exec 0 0" | tee -a /etc/fstab >/dev/null
}

copypicom() {
    cp /home/$name/.config/dev/picom.conf /etc/xdg/picom.conf
}

service() {
    ln -sf /etc/sv/dbus /var/service
    ln -sf /etc/sv/cronie /var/service
}

# Make directory for other hdd/sdd.
makedir

# Set UUID of other hdd/sdd in fstab.
getuuid

# Copy picom config
copypicom

# Set dbus service
service

echo '\033[0;32mRun ./4_fmanager.sh and reboot.'

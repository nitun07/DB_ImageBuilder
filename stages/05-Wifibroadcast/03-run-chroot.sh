# On chroot

sudo rm /etc/init.d/resize2fs_once


# Make symbolic link for osdconfig.txt
sudo rm /home/pi/DroneBridge/osd/osdconfig.h
sudo ln -s /DroneBridge/osdconfig.txt /home/pi/DroneBridge/osd/osdconfig.h


#enable txpower from command line and RemoteSettings app
sudo chmod 755 /usr/local/bin/txpower_atheros
sudo chmod 755 /usr/local/bin/txpower_ralink


#other permissions
sudo chmod 755 /etc/init.d/raspi-config
sudo chmod 664 /etc/dhcpcd.conf
sudo chmod 755 /boot/cmdline.txt
sudo chmod 755 /boot/config.txt
sudo chmod 644 /etc/modprobe.d/*.conf
sudo chmod 644 /etc/fstab
sudo chmod 644 /lib/firmware/ath9k_htc/htc_9271-1.4.0.fw
sudo chmod 644 /lib/udev/rules.d/51-android.rules
sudo chmod 644 /lib/firmware/regulatory.db
sudo chmod 644 /lib/firmware/regulatory.db.p7s
sudo chmod 644 /lib/crda/regulatory.bin
sudo chmod 644 /lib/crda/pubkeys/pi.key.pub.pem


#change hostname
CURRENT_HOSTNAME=`sudo cat /etc/hostname | sudo tr -d " \t\n\r"`
NEW_HOSTNAME="dronebridge"
if [ $? -eq 0 ]; then
  sudo sh -c "echo '$NEW_HOSTNAME' > /etc/hostname"
  sudo sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
fi

apt -y autoremove
apt -y clean

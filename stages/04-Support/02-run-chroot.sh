# On chroot


#disable unneeded services
sudo systemctl disable cron.service


#hosstapd fix
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd


#enable /dev/video0
#sudo modprobe bcm2835-v4l2






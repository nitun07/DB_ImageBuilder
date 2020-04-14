# On chroot

#Ensure the runlevel is multi-target (3) could possibly be lower...
sudo systemctl set-default multi-user.target


#disable unneeded services
sudo systemctl disable cron.service


#hosstapd fix
sudo systemctl unmask hostapd
sudo systemctl stop hostapd
sudo systemctl stop hostapd
sudo systemctl disable hostapd






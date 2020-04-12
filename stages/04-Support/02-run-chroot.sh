# On chroot

#Ensure the runlevel is multi-target (3) could possibly be lower...
sudo systemctl set-default multi-user.target

#disable unneeded services
sudo systemctl disable cron.service

#Disable does not work on PLYMOUTH
sudo systemctl mask plymouth-start.service
sudo systemctl mask plymouth-read-write.service
sudo systemctl mask plymouth-quit-wait.service
sudo systemctl mask plymouth-quit.service


#enable /dev/video0
#sudo modprobe bcm2835-v4l2






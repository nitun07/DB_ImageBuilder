# This runs in context if the image (CHROOT)
# Any native compilation can be done here
# Do not use log here, it will end up in the image

#!/bin/bash

# Compile & install DroneBridge
cd /home/pi
cd DroneBridge
sudo cmake . && make
cd communication/DroneBridgeLib
sudo pip3 install .

cd /home/pi
cd DroneBridge
sudo cp start_db /etc/init.d/start_db
sudo chmod 755 /etc/init.d/start_db

sudo update-rc.d -f start_db remove
sudo update-rc.d start_db defaults

sudo cp rsyslog.conf /etc/
sudo chmod 644 /etc/rsyslog.conf
sudo cp logrotate_rsyslog_conf /etc/logrotate.d/rsyslog
sudo chmod 644 /etc/logrotate.d/rsyslog


cd /home/pi


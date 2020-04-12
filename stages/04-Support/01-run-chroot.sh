# This runs in context if the image (CHROOT)
# Any native compilation can be done here
# Do not use log here, it will end up in the image

#!/bin/bash

#Compile Raspberry Pi media libs
cd /opt/vc/src/hello_pi/
sudo make


#Install openvg
cd /home/pi
cd openvg
sudo make
sudo make library
sudo make install
sudo cp eglstate.h /usr/include/
sudo chmod 644 /usr/include/eglstate.h


cd /home/pi

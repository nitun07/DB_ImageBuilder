# This runs in context if the image (CHROOT)
# Any native compilation can be done here
# Do not use log here, it will end up in the image

#!/bin/bash

# Remove bad and unnecessary symlinks 
rm /lib/modules/*/build || true
rm /lib/modules/*/source || true

if [ "${APT_CACHER_NG_ENABLED}" == "true" ]; then
    echo "Acquire::http::Proxy \"${APT_CACHER_NG_URL}/\";" >> /etc/apt/apt.conf.d/10cache
fi



apt-mark hold raspberrypi-bootloader
apt-mark hold raspberrypi-kernel


sudo apt-get update || exit 1
sudo apt-get -y upgrade || exit 1


#DroneBridge required package
DEBIAN_FRONTEND=noninteractive sudo apt-get -y --no-install-recommends install python3.7 python3-pip ntp python3-psutil python3-serial python3-sysv-ipc python3-netifaces python3-rpi.gpio python3-evdev joystick hostapd cmake wiringpi udhcpd libusb-1.0-0.dev libpcap-dev exfat-fuse exfat-utils dos2unix pump || exit 1


DEBIAN_FRONTEND=noninteractive sudo apt-get -y --no-install-recommends install libfontconfig1-dev libjpeg8-dev libpng-dev indent libfreetype6-dev ttf-dejavu-core || exit 1

DEBIAN_FRONTEND=noninteractive sudo apt-get -y --no-install-recommends install git python-m2crypto bc raspberrypi-kernel-headers dkms || exit 1

sudo pip3 install pyric pycryptodomex


DEBIAN_FRONTEND=noninteractive sudo apt-get -yq clean || exit 1
DEBIAN_FRONTEND=noninteractive sudo apt-get -yq autoremove || exit 1


if [ ${APT_CACHER_NG_ENABLED} == "true" ]; then
    rm /etc/apt/apt.conf.d/10cache
fi

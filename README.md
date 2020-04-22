# DroneBridge-Image-Builder
This project takes a Raspbian-lite base image and modifies it into a DroneBridge compatible image.

## Usage
In order to be able to run this you need a Debian or Ubuntu Linux machine with 40 Gb free space on the main partition, and with the following packages:

```
sudo apt-get install unzip curl git qemu qemu-user-static binfmt-support build-essential bc bison flex libssl-dev make libc6-dev libncurses5-dev libelf-dev gcc-arm* exfat-utils
```

Then git clone this repository to a suitable folder 

```
https://github.com/nitun07/DB_ImageBuilder.git
cd DB_ImageBuilder
```

and run:

```
sudo -s
./build.sh
```

## References
Thanks to Open.HD for the base idea.

```
https://github.com/OpenHD/Open.HD_Image_Builder
```


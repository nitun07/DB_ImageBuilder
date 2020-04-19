set -e

# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}
MNT_DIR="${STAGE_WORK_DIR}/mnt"

log "Compile kernel for Pi 2, Pi 3, Pi 3+, or Compute Module 3/3+"
pushd ${LINUX_DIR}

log "Compiling Kernel7 config"

make clean && make mrproper ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-

KERNEL=kernel7 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make bcm2709_defconfig

sudo sed -i 's/CONFIG_DEFAULT_HOSTNAME="(none)"/CONFIG_DEFAULT_HOSTNAME="DroneBridge"/' .config
sudo sed -i 's/# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set/CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y/' .config
sudo sed -i 's/CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y/# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set/' .config
sudo sed -i 's/# CONFIG_88XXAU is not set/CONFIG_88XXAU=y/' .config


yes "" | KERNEL=kernel7 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j $J_CORES zImage modules dtbs

log "Saving kernel as ${STAGE_WORK_DIR}/kernel7.img"
cp arch/arm/boot/zImage "${MNT_DIR}/boot/kernel7.img" || exit 1

log "Copy the kernel modules for Pi 2, Pi 3, Pi 3+, or Compute Module 3/3+"
make -j $J_CORES ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH="$MNT_DIR" modules_install

log "Copy the DTBs for Pi 2, Pi 3, Pi 3+, or Compute Module 3/3+"
sudo cp arch/arm/boot/dts/*.dtb "${MNT_DIR}/boot/" || exit 1
sudo cp arch/arm/boot/dts/overlays/*.dtb* "${MNT_DIR}/boot/overlays/" || exit 1
sudo cp arch/arm/boot/dts/overlays/README "${MNT_DIR}/boot/overlays/" || exit 1

# out of linux 
popd

#return 
popd

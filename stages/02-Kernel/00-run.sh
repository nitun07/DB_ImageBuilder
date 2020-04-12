set -e

# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}


if [ ! -d "${LINUX_DIR}" ]; then
    log "Download the kernel"
    git clone --depth=1 -b ${KERNEL_BRANCH} ${KERNEL_REPO} ${LINUX_DIR}
fi

pushd ${LINUX_DIR}

#copy patch files to kernel directory
log "Patching the kernel"
cp "${STAGE_DIR}/FILES/ath9k_power_channel_unlock.patch" ./ath9k_power_channel_unlock.patch || exit 1
patch -p1 < ath9k_power_channel_unlock.patch
cp "${STAGE_DIR}/FILES/brcm_int_wifi.patch" ./brcm_int_wifi.patch || exit 1
patch -p1 < brcm_int_wifi.patch
cp "${STAGE_DIR}/FILES/rt2800_power_param.patch" ./rt2800_power_param.patch || exit 1
patch -p1 < rt2800_power_param.patch

popd


popd

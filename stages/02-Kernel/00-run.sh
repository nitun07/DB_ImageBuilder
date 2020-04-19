set -e

# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}


if [ ! -d "${LINUX_DIR}" ]; then
    log "Download the kernel"
    git clone --depth=1 -b ${KERNEL_BRANCH} ${KERNEL_REPO} ${LINUX_DIR}
fi

pushd ${REALTEK_DIR}
log "Download rtl8812au"
git clone --depth=1 -b ${RTL_8812AU_BRANCH} ${RTL_8812AU_REPO} || exit 1
popd

pushd ${LINUX_DIR}

#copy patch files to kernel directory
log "Patching the kernel"
cp "${STAGE_DIR}/FILES/ath9k_power_channel_unlock.patch" ./ath9k_power_channel_unlock.patch || exit 1
patch -p1 < ath9k_power_channel_unlock.patch
cp "${STAGE_DIR}/FILES/brcm_int_wifi.patch" ./brcm_int_wifi.patch || exit 1
patch -p1 < brcm_int_wifi.patch
cp "${STAGE_DIR}/FILES/rt2800_power_param.patch" ./rt2800_power_param.patch || exit 1
patch -p1 < rt2800_power_param.patch
cp "${STAGE_DIR}/FILES/rtl8812au.patch" ./rtl8812au.patch || exit 1
patch -p1 < rtl8812au.patch

popd


popd

# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Install QEMU"

MNT_DIR="${STAGE_WORK_DIR}/mnt"
sudo cp /usr/bin/qemu-arm-static "${MNT_DIR}/usr/bin"

log "Clear the preload file"
sudo cp "${MNT_DIR}/etc/ld.so.preload" "${MNT_DIR}/root"
sudo cp /dev/null "${MNT_DIR}/etc/ld.so.preload"


EXFAT_FORMAT=0

#return
popd

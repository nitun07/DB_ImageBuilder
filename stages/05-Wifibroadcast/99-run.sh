# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

MNT_DIR="${STAGE_WORK_DIR}/mnt"
sudo cp "$MNT_DIR/root/ld.so.preload" "$MNT_DIR/etc/ld.so.preload"


# Rename the Exfat partition
EXFAT_MNT_DIR="${STAGE_WORK_DIR}/mnt/DroneBridge"
EXFAT_LOOP_DEV="$(findmnt -nr -o source $EXFAT_MNT_DIR)"

exfatlabel "$EXFAT_LOOP_DEV" "DroneBridge"


#return
popd

# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

MNT_DIR="${STAGE_WORK_DIR}/mnt"

log "Removing old GIT dir"
rm -r GIT || true

mkdir -p GIT

pushd GIT


log "Download openvg"
git clone --depth=1 -b ${OPENVG_BRANCH} ${OPENVG_REPO} || exit 1




#return
popd


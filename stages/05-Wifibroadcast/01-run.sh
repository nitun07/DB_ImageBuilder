# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Removing old GIT dir"
rm -r GIT || true

mkdir -p GIT

pushd GIT

MNT_DIR="${STAGE_WORK_DIR}/mnt"

log "Download DroneBridge Sources REPO=${DRONEBRIDGE_REPO} BRANCH=${DRONEBRIDGE_BRANCH}"
sudo git clone --depth=1 -b ${DRONEBRIDGE_BRANCH} ${DRONEBRIDGE_REPO} || exit 1
pushd DroneBridge
sudo git submodule update --init --recursive  || exit 1
DRONEBRIDGE_VERSION=$(git describe --always --tags)
export DRONEBRIDGE_VERSION
popd

# store the commit used for the Open.HD repo as well as the builder inside the image
# to allow tracing problems and changes back to the source, even if the image is renamed
echo ${DRONEBRIDGE_VERSION} > ${MNT_DIR}/dronebridge_version.txt
echo ${BUILDER_VERSION} > ${MNT_DIR}/builder_version.txt
echo ${DRONEBRIDGE_VERSION} > ${MNT_DIR}/boot/dronebridge_version.txt
echo ${BUILDER_VERSION} > ${MNT_DIR}/boot/builder_version.txt
# copy the Open.HD repo version back down to the work folder so build.sh can retrieve it and use it
# in the name of the image being built
cp ${MNT_DIR}/dronebridge_version.txt ${STAGE_WORK_DIR}/../


#return
popd
popd


# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Copy all WFB Sources to RPi image"

MNT_DIR="${STAGE_WORK_DIR}/mnt"

cp -r GIT/. "$MNT_DIR/home/pi/"


EXFAT_FORMAT=0
#return
popd

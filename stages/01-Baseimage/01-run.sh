# Do this to the WORK folder of this stage
pushd ${STAGE_WORK_DIR}

log "Create 2Gb empty image"
dd if=/dev/zero of=temp.img bs=1 count=1 seek=2G


log "Enlarge the downloaded image by 2Gb"
cat temp.img >> IMAGE.img

log "fdisk magic to enlarge the main partition"

PARTED_OUT=$(parted -s IMAGE.img unit s print)
ROOT_OFFSET_START=$(echo "$PARTED_OUT" | grep -e '^ 2'| xargs echo -n \
    | cut -d" " -f 2 | tr -d s)

ROOT_SIZE=6291455
ROOT_OFFSET_END=$(($ROOT_OFFSET_START + $ROOT_SIZE))
EXFAT_OFFSET=$(($ROOT_OFFSET_END + 1))

echo "ROOT OFFSET START: $ROOT_OFFSET_START"
echo "ROOT OFFSET END: $ROOT_OFFSET_END"
echo "ExFAT OFFSET END: $EXFAT_OFFSET"

fdisk IMAGE.img <<EOF
d
2
n
p
2
${ROOT_OFFSET_START}
${ROOT_OFFSET_END}
n
p
3
${EXFAT_OFFSET}

t
3
7
w
EOF

EXFAT_FORMAT=1

# return
popd

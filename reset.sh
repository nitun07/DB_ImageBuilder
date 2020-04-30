#!/bin/bash -e


echo "Reset Image Builder"
echo "------------------------------------------------------"
echo ""

echo "Usage: ./reset.sh"
echo "------------------------------------------------------"
echo ""

if [ -d "work-directory" ]; then
    pushd "work-directory"
        find . -type f -name 'SKIP' -delete
        find . -type f -name 'SKIP_STEP*' -delete
        find . -type f -name 'SKIP_CH_STEP*' -delete
        find . -type f -name 'IMAGE.img' -delete
    popd
fi

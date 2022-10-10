#!/bin/bash

# This script copies an ISO image to several USB keys at once.
# Mounted partitions are automatically umounted.

app=`basename $0`

if [ $# -lt 2 ]; then
    echo "usage: $app ISO a b c ..."
    echo "ISO    ISO file to copy to multiple devices"
    echo "a      /dev/sdX device to copy the ISO to"
    echo "       a means /dev/sda, b means /dev/sdb, etc."
    echo "Example:"
    echo "Copy live-debian.iso to /dev/sdb, /dev/sdi and /dev/sdh"
    echo "$app live-debian.iso b i h"
    exit 1
fi

src=$1
shift 1
dst=""
devices=""
for i in "$@"; do
    devices="$devices /dev/sd$i"
done

echo "Source ISO file: $src"
echo "Destination devices: $devices"

while true; do
    read -p "Proceed? (y/n) " yn
    case $yn in
        [Yy]*)
            for i in "$@"; do
                dst="$dst of=/dev/sd$i"
                for part in {1..10}; do
                    umount /dev/sd$i$part 2>/dev/null
                done
            done

            dcfldd if=$src $dst
            status=$?
            sync
            if [ $status = 0 ]; then
                echo "Image copies successful."
            else
                echo "Image copies failed!"
            fi

            exit $status
            break;;

        [Nn]*) exit 1;;
        * ) echo "Please enter \"y\" or \"n\"";;
    esac
done

exit 1

#!/bin/bash

# This script umounts, in bulk, all partitions on the specified devices.

app=`basename $0`

if [ $# -lt 2 ]; then
    echo "usage: $app a b c ..."
    echo "a      umounts all partitions from device /dev/sdX"
    echo "       a means /dev/sda, b means /dev/sdb, etc."
    exit 1
fi

for i in "$@"; do
    for part in {1..10}; do
        umount /dev/sd$i$part 2>/dev/null
    done
done

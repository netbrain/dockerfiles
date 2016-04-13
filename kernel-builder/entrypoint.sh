#!/bin/bash
: ${1?"Need to set kernel version with first argument"}

set -e

cd /usr/src
curl -k -L https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-$1.tar.gz | tar xzv
cp .config linux-$1/
cd linux-$1

yes "" | make oldconfig
cp .config ../.config-linux-$1-$(date +%s)
make-kpkg clean
make-kpkg -j 8 --initrd kernel-image kernel-headers

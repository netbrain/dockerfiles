#!/bin/bash
: ${1?"Need to set kernel version with first argument"}

set -e

cd /usr/src
if [ ! -d linux ]; then
  git clone --depth 1 --single-branch git://github.com/torvalds/linux.git linux 
fi
cp .config linux/
cd linux

git fetch origin v$1 --depth 1
git checkout tags/v$1

yes "" | make oldconfig
cp .config ../.config-linux-$1-$(date +%s)
make-kpkg clean
make-kpkg -j 8 --initrd kernel-image kernel-headers

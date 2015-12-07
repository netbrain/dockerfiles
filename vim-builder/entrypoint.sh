#!/bin/bash
git clone --depth 1 https://github.com/vim/vim $VIM_HOME
./configure \
  --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp \
  --enable-pythoninterp \
  --with-python-config-dir=/usr/lib/python2.7/config \
  --enable-perlinterp \
  --enable-luainterp \
  --enable-cscope \
  --with-x && make && checkinstall -y \
  --type=debian \
  --pkgname=vim \
  --pkgsource=$VIM_HOME \
  --pkgversion=$(cat src/version.h | grep "#define VIM_VERSION_SHORT" | egrep -o "[0-9]+\.[0-9]+") \
  --pkgrelease=netbrain

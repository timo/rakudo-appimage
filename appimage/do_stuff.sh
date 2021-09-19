#!/bin/bash

########################################################################
# Package the binaries built on Travis-CI as an AppImage
# By Simon Peter 2016
# For more information, see http://appimage.org/
########################################################################

set -xe

export ARCH="$(arch)"
export VERSION="2021.09"

APP=rakudo
LOWERAPP=$APP

mkdir -p "$HOME/$APP/$APP.AppDir/usr/"
BUILD_PATH="$(pwd)"

git clone https://github.com/rakudo/rakudo
cd rakudo
pwd
ls -l
git checkout $VERSION
sudo perl Configure.pl --prefix="/usr/rakudo/" --gen-moar --relocatable
sudo make -j2 install

cd ../
pwd
ls -l

cd "$BUILD_PATH/appimage"

wget -q https://github.com/AppImage/pkg2appimage/releases/download/continuous/pkg2appimage-1807-x86_64.AppImage -O ./pkg2appimage.AppImage
chmod +x ./pkg2appimage.AppImage

mkdir -p ../out/
./pkg2appimage.AppImage ./Rakudo.yml

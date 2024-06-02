#!/bin/bash
#Dependent Libraries
BuildToolsDeps="build-essential gcc g++ make cmake cmake-data autoconf automake pkg-config libtool"
DownloadToolsDeps="wget curl"
UtilityToolsDeps="patch vim zip unzip 7zip bc dc expect rsyslog lrzsz chrony psmisc lsof"
UbuntuToolsDeps="debian-keyring debian-archive-keyring apt-transport-https ca-certificates software-properties-common gnupg neofetch"
RuntimeDeps="libicu70 libglib2.0-0 zlib1g libc6 libbz2-1.0 libncurses5 libaio1 libkrb5-3 openssl libnss3 libjpeg8 libbz2-1.0 libxml2"
DevDeps="libglib2.0-dev libxml2-dev libperl-dev zlib1g-dev libc-client2007e-dev libzip-dev libncurses5-dev libaio-dev libreadline-dev libcurl4-gnutls-dev libltdl-dev libsasl2-dev libxslt-dev libicu-dev libsqlite3-dev libexpat1-dev libssl-dev libonig-dev libtirpc-dev libjpeg8-dev libpng-dev librsvg2-dev libtiff-dev libgif-dev libidn11-dev gettext"

FFmpegDeps="nasm libchromaprint-dev frei0r-plugins-dev libgmp-dev ladspa-sdk libaom-dev libass-dev libbluray-dev libbs2b-dev libslang2-dev libcaca-dev libcdio-dev libcodec2-dev libdav1d-dev libdavs2-dev libdc1394-dev libfdk-aac-dev flite1-dev libfontconfig1-dev libfreetype6-dev libfribidi-dev libgme-dev libgsm1-dev libavc1394-dev libiec61883-dev libjack-dev liblensfun-dev check libcheck-dev libxml2 libxml2-dev yasm libjpeg-dev libtiff-dev libpng-dev libmodplug-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libopencv-dev libopenjp2-7-dev libopenmpt-dev libopus-dev libplacebo-dev librsvg2-dev librubberband-dev librtmp-dev libshine-dev libsnappy-dev libsoxr-dev libspeex-dev libsrt-openssl-dev libssh-dev libtheora-dev libtesseract-dev libtwolame-dev libvidstab-dev libvo-amrwbenc-dev libvorbis-dev libvpx-dev libwebp-dev libx264-dev libx265-dev libxavs2-dev libxvidcore-dev libxml2-dev libzimg-dev libzmq5-dev libzvbi-dev liblilv-dev libomxil-bellagio-dev libmysofa-dev libopenal-dev ocl-icd-opencl-dev libopengl-dev libsdl2-dev libpocketsphinx-dev libdrm-dev"

#UbuntuPkgList you can cusotom,ex: UbuntuPkgList="${BuildToolsDeps} ${DownloadToolsDeps}" or UbuntuPkgList="wget gcc"
installDepsUbuntu() {
  for Package in ${UbuntuPkgList}; do
    if ! dpkg -s ${Package} > /dev/null 2>&1; then
      apt-get install -y ${Package}
    fi
  done
}

#include src libary
. ./devbase/system-lib/icu_config.sh
. ./devbase/system-lib/libevent.sh
. ./devbase/system-lib/libwebp.sh
. ./devbase/system-lib/openssl.sh
. ./devtools/files/git.sh

installDepsBySrc() { 
  Install_Icu4c
  Install_Libevent
  Install_Libwebp
  Install_Git
  
  if command -v lsof >/dev/null 2>&1; then
    echo 'already initialize' > ~/.oneinstack
  else
    echo "${CFAILURE}${PM} config error parsing file failed${CEND}"
    kill -9 $$; exit 1;
  fi
}
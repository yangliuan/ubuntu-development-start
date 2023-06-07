#!/bin/bash
#Dependent Libraries
BuildToolsDeps="build-essential gcc g++ make cmake cmake-data autoconf automake pkg-config libtool wget git curl"
UbuntuToolsDeps="debian-keyring debian-archive-keyring apt-transport-https ca-certificates software-properties-common gnupg"
UtilityToolsDeps="patch vim zip unzip 7zip tmux bc dc expect rsyslog lrzsz chrony psmisc lsof"
DevDeps="libglib2.0-dev libxml2-dev libperl-dev zlib1g-dev libc-client2007e-dev libbz2-1.0 libzip-dev libncurses5-dev libaio-dev libreadline-dev libcurl4-gnutls-dev libltdl-dev libsasl2-dev libxslt-dev libicu-dev libsqlite3-dev libexpat1-dev"
RuntimeDeps="libicu70 libglib2.0-0 zlib1g libc6 libbz2-1.0 libncurses5 libaio1 libkrb5-3 libidn11-dev openssl libssl-dev libonig-dev libnss3 libtirpc-dev"
ImageExtensionDeps="libjpeg8 libjpeg8-dev libpng-dev librsvg2-dev libtiff-dev libgif-dev"

FFmpegDeps="nasm libchromaprint-dev frei0r-plugins-dev libgmp-dev ladspa-sdk libaom-dev libass-dev libbluray-dev libbs2b-dev libslang2-dev libcaca-dev libcdio-dev libcodec2-dev libdav1d-dev libdavs2-dev libdc1394-dev libfdk-aac-dev flite1-dev libfontconfig1-dev libfreetype6-dev libfribidi-dev libgme-dev libgsm1-dev libjack-dev libmp3lame-dev libmysofa-dev libopenjp2-7-dev libopenmpt-dev libopus-dev librubberband-dev libshine-dev libsnappy-dev libsoxr-dev libspeex-dev libsrt-openssl-dev libssh-dev libtheora-dev libtwolame-dev libvidstab-dev libvorbis-dev libvpx-dev libwebp-dev libx265-dev libx264-dev libxml2-dev libxvidcore-dev libzimg-dev libzmq5-dev libzvbi-dev liblilv-dev libomxil-bellagio-dev libopenal-dev ocl-icd-opencl-dev libopengl-dev libsdl2-dev libpocketsphinx-dev librsvg2-dev libmfx-dev libmfx-gen-dev libdrm-dev libavc1394-dev libiec61883-dev librtmp-dev"

FceuxDeps="qtbase5-dev zlib1g-dev libminizip-dev libsdl2-dev liblua5.1-dev qttools5-dev libx264-dev libx265-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libswresample-dev cppcheck"

. ./devbase/system-lib/icu_config.sh
. ./devbase/system-lib/libevent.sh
. ./devbase/multimedia/libwebp.sh
. ./devbase/system-lib/openssl.sh

installBuildUbuntuTool() {
  for buildDep in ${BuildToolsDeps}; do
    apt-get -y install ${buildDep}
  done
}

installDepsUbuntu() {
  pkgList="${UbuntuToolsDeps} ${UtilityToolsDeps} ${DevDeps} ${RuntimeDeps} ${ImageExtensionDeps}"

  for Package in ${pkgList}; do
    apt-get install -y ${Package}
  done
}

installDepsBySrc() { 
  if ! command -v icu-config > /dev/null 2>&1 || icu-config --version | grep '^3.' || [ "${Ubuntu_ver}" == "20" ]; then
    Install_Icu4c
  fi

  Install_OpenSSL
  Install_Libevent
  Install_Libwebp

  if command -v lsof >/dev/null 2>&1; then
    echo 'already initialize' > ~/.oneinstack
  else
    echo "${CFAILURE}${PM} config error parsing file failed${CEND}"
    kill -9 $$; exit 1;
  fi
}
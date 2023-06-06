#!/bin/bash
installDepsUbuntu() {
  build_tool="build-essential gcc g++ make cmake cmake-data autoconf pkg-config libtool wget git"
  ubuntu_tool="debian-keyring debian-archive-keyring apt-transport-https ca-certificates software-properties-common gnupg"
  dev_deps="libglib2.0-dev libxml2-dev libperl-dev zlib1g-dev libc-client2007e-dev libbz2-1.0 libzip-dev libncurses5-dev libaio-dev libreadline-dev libcurl4-gnutls-dev libltdl-dev libsasl2-dev libxslt-dev libicu-dev libsqlite3-dev libexpat1-dev"
  pics_extension_deps="libjpeg8 libjpeg8-dev libpng-dev"
  runtime_deps="libicu70 libglib2.0-0 zlib1g libc6 libbz2-1.0 libncurses5 libaio1 libkrb5-3 libidn11-dev openssl libssl-dev libonig-dev libnss3 libtirpc-dev"
  utility_tools="patch vim zip unzip tmux bc dc expect rsyslog lrzsz chrony psmisc lsof"
  pkgList="${build_tool} ${ubuntu_tool} ${dev_deps} ${pics_extension_deps} ${runtime_deps} ${utility_tools}"

  for Package in ${pkgList}; do
    apt-get -y install ${Package}
  done
}

installDepsBySrc() {
  . ./devbase/system-lib/icu_config.sh
  . ./devbase/system-lib/libevent.sh
  . ./devbase/multimedia/libwebp.sh
  Install_Libevent
  Install_Libwebp
  
  if ! command -v icu-config > /dev/null 2>&1 || icu-config --version | grep '^3.' || [ "${Ubuntu_ver}" == "20" ]; then
    Install_Icu4c
  fi

  if command -v lsof >/dev/null 2>&1; then
    echo 'already initialize' > ~/.oneinstack
  else
    echo "${CFAILURE}${PM} config error parsing file failed${CEND}"
    kill -9 $$; exit 1;
  fi
}

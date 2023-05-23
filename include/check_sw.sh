#!/bin/bash
. ./include/system-lib/libevent.sh
. ./include/multimedia/libwebp.sh

installDepsUbuntu() {
  pkgList="libicu70 libglib2.0-dev libxml2-dev libperl-dev debian-keyring debian-archive-keyring build-essential gcc g++ make cmake autoconf libjpeg8 libjpeg8-dev libpng-dev libpng12-0 libpng12-dev libpng3 libxml2 libxml2-dev zlib1g zlib1g-dev libc6 libc6-dev libc-client2007e-dev libglib2.0-0 libglib2.0-dev bzip2 libzip-dev libbz2-1.0 libncurses5 libncurses5-dev libaio1 libaio-dev numactl libreadline-dev curl libcurl3-gnutls libcurl4-gnutls-dev libcurl4-openssl-dev e2fsprogs libkrb5-3 libkrb5-dev libltdl-dev libidn11 libidn11-dev openssl net-tools libssl-dev libtool re2c libsasl2-dev libxslt1-dev libxslt-dev libicu-dev libsqlite3-dev libcloog-ppl1 bison patch vim zip unzip tmux htop bc dc expect libexpat1-dev rsyslog libonig-dev libtirpc-dev libnss3 rsync git lsof lrzsz chrony psmisc wget sysv-rc apt-transport-https ca-certificates software-properties-common gnupg ufw"
  
  for Package in ${pkgList}; do
    apt-get -y install ${Package}
  done
}

installDepsBySrc() {
  Install_Libevent
  Install_Libwebp
  
  pushd ${oneinstack_dir}/src > /dev/null
  if ! command -v icu-config > /dev/null 2>&1 || icu-config --version | grep '^3.' || [ "${Ubuntu_ver}" == "20" ]; then
    tar xzf icu4c-${icu4c_ver}-src.tgz
    pushd icu/source > /dev/null
    ./configure --prefix=/usr/local
    make -j ${THREAD} && make install
    popd > /dev/null
    rm -rf icu
  fi

  if command -v lsof >/dev/null 2>&1; then
    echo 'already initialize' > ~/.oneinstack
  else
    echo "${CFAILURE}${PM} config error parsing file failed${CEND}"
    kill -9 $$; exit 1;
  fi
  popd > /dev/null
}

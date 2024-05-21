#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_memcached_server() {
  pushd ${ubdevenv_dir}/src/devbase/database > /dev/null
  # memcached-server
  echo "Download memcached-server..."
  src_url=http://www.memcached.org/files/memcached-${memcached_ver}.tar.gz && Download_src
  
  # memcached server
  id -u memcached >/dev/null 2>&1
  [ $? -ne 0 ] && useradd -M -s /sbin/nologin memcached

  tar xzf memcached-${memcached_ver}.tar.gz
  pushd memcached-${memcached_ver} > /dev/null
  [ ! -d "${memcached_install_dir}" ] && mkdir -p ${memcached_install_dir}
  ./configure --prefix=${memcached_install_dir} --with-libevent=${libevent_install_dir}
  make -j ${THREAD} && make install
  popd > /dev/null
  if [ -f "${memcached_install_dir}/bin/memcached" ]; then
    echo "${CSUCCESS}memcached installed successfully! ${CEND}"
    rm -rf memcached-${memcached_ver}
    ln -s ${memcached_install_dir}/bin/memcached /usr/bin/memcached
    
    /bin/cp ${ubdevenv_dir}/init.d/memcached.service /lib/systemd/system/
    systemctl enable memcached
    systemctl start memcached
    
    rm -rf memcached-${memcached_ver}
  else
    rm -rf ${memcached_install_dir}
    echo "${CFAILURE}memcached-server install failed, Please contact the author! ${CEND}" && lsb_release -a
    kill -9 $$; exit 1;
  fi
  popd > /dev/null
}


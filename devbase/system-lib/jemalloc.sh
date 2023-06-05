#!/bin/bash
Install_Jemalloc() {
  if [ ! -e "/usr/local/lib/libjemalloc.so" ]; then
    pushd ${ubdevenv_dir}/src > /dev/null
    tar xjf jemalloc-${jemalloc_ver}.tar.bz2
    pushd jemalloc-${jemalloc_ver} > /dev/null
    ./configure
    make -j ${THREAD} && make install
    popd > /dev/null
    if [ -f "/usr/local/lib/libjemalloc.so" ]; then
      ln -s /usr/local/lib/libjemalloc.so.2 /usr/lib/libjemalloc.so.1
      [ -z "`grep /usr/local/lib /etc/ld.so.conf.d/*.conf`" ] && echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf
      ldconfig
      echo "${CSUCCESS}jemalloc module installed successfully! ${CEND}"
      rm -rf jemalloc-${jemalloc_ver}
    else
      echo "${CFAILURE}jemalloc install failed, Please contact the author! ${CEND}" && lsb_release -a
      kill -9 $$; exit 1;
    fi
    popd > /dev/null
  fi
}

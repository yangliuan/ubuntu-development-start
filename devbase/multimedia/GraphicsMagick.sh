#!/bin/bash
#PC: http://www.graphicsmagick.org/
#http://www.graphicsmagick.org/download.html
#http://www.graphicsmagick.org/INSTALL-unix.html#build-configuration
Install_GraphicsMagick() {
  if [ -d "${gmagick_install_dir}" ]; then
    echo "${CWARNING}GraphicsMagick already installed! ${CEND}"
  else
    pushd ${ubdevenv_dir}/src/devbase/multimedia > /dev/null
    tar xzf GraphicsMagick-${graphicsmagick_ver}.tar.gz
      pushd GraphicsMagick-${graphicsmagick_ver} > /dev/null
      ./configure --prefix=${gmagick_install_dir} --enable-shared --enable-static --enable-symbol-prefix
      make -j ${THREAD} && make install
      popd > /dev/null
    rm -rf GraphicsMagick-${graphicsmagick_ver}
    popd > /dev/null
  fi
}

Uninstall_GraphicsMagick() {
  if [ -d "${gmagick_install_dir}" ]; then
    rm -rf ${gmagick_install_dir}
    echo; echo "${CMSG}GraphicsMagick uninstall completed${CEND}"
  fi
}
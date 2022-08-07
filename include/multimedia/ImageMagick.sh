#!/bin/bash
Install_ImageMagick() {
  if [ -d "${imagick_install_dir}" ]; then
    echo "${CWARNING}ImageMagick already installed! ${CEND}"
  else
    pushd ${oneinstack_dir}/src > /dev/null
    tar xzf ImageMagick-${imagemagick_ver}.tar.gz
    #apt-get install libwebp-dev
    pushd ImageMagick-${imagemagick_ver} > /dev/null
    #启用webp格式支持
    ./configure --prefix=${imagick_install_dir} --enable-shared --enable-static --with-webp
    make -j ${THREAD} && make install
    popd > /dev/null
    rm -rf ImageMagick-${imagemagick_ver}
    popd > /dev/null
  fi
}

Uninstall_ImageMagick() {
  if [ -d "${imagick_install_dir}" ]; then
    rm -rf ${imagick_install_dir}
    echo; echo "${CMSG}ImageMagick uninstall completed${CEND}"
  fi
}
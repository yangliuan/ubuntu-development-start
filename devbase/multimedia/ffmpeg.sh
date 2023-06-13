#!/bin/bash
#DOC https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
#Download https://ffmpeg.org/download.html#releases
#REPO https://github.com/FFmpeg/FFmpeg/tags
Install_FFmpeg() {
  apt-get install -y ffmpeg
}

Install_FFmpeg_Build() {
  [ -e "/usr/bin/ffmpeg" ] && apt-get -y autoremove ffmpeg

  UbuntuPkgList="${FFmpegDeps}" && installDepsUbuntu
  . ${ubdevenv_dir}/devbase/multimedia/libvmaf.sh
  Install_Libvmaf
  . ${ubdevenv_dir}/devbase/multimedia/libjxl.sh
  Install_Libjxl
  #. ${ubdevenv_dir}/devbase/multimedia/kvazaar.sh
  #Install_Kvazaar
  # . ${ubdevenv_dir}/devbase/multimedia/librav1e.sh
  # Install_Librav1e

  pushd ${ubdevenv_dir}/src > /dev/null
  src_url=https://ffmpeg.org/releases/ffmpeg-${ffmpeg_ver}.tar.xz && Download_src
  tar -xJf ffmpeg-${ffmpeg_ver}.tar.xz
  pushd ffmpeg-${ffmpeg_ver} > /dev/null
  #export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH
  #export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
  ./configure \
  --enable-gpl \
  --enable-version3 \
  --enable-nonfree \
  --enable-chromaprint \
  --enable-frei0r \
  --enable-gmp \
  --enable-ladspa \
  --enable-libaom \
  --enable-libass \
  --enable-libbluray \
  --enable-libbs2b \
  --enable-libcaca \
  --enable-libcodec2 \
  --enable-libdav1d \
  --enable-libdavs2 \
  --enable-libdc1394 \
  --enable-libfdk-aac \
  --enable-libflite \
  --enable-libfontconfig \
  --enable-libfreetype \
  --enable-libfribidi \
  --enable-libgme \
  --enable-libgsm \
  --enable-libiec61883 \
  --enable-libjack \
  --enable-libjxl \
  --enable-liblensfun \
  --enable-libmodplug \
  --enable-libmp3lame \
  --enable-libopencore-amrnb \
  --enable-libopencore-amrwb \
  --enable-libopenjpeg \
  --enable-libopenmpt \
  --enable-libopus \
  --enable-libplacebo \
  --enable-libpulse \
  --enable-librsvg \
  --enable-librubberband \
  --enable-librtmp \
  --enable-libshine \
  --enable-libsnappy \
  --enable-libsoxr \
  --enable-libspeex \
  --enable-libsrt \
  --enable-libssh \
  --enable-libtesseract \
  --enable-libtheora \
  --enable-libtwolame \
  --enable-libvidstab \
  --enable-libvmaf \
  --enable-libvo-amrwbenc \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libwebp \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libxvid \
  --enable-libxml2 \
  --enable-libzimg \
  --enable-libzmq \
  --enable-libzvbi \
  --enable-lv2 \
  --enable-omx \
  --enable-libmysofa \
  --enable-openal \
  --enable-opencl \
  --enable-opengl \
  --enable-sdl2 \
  --enable-pocketsphinx \
  --enable-cuda-nvcc \
  --enable-libdrm \
  --enable-libnpp
  
  # --enable-libkvazaar \ 通过 libkvazaar 进行 HEVC（High Efficiency Video Coding）编码的功能。libkvazaar 是一个开源的 HEVC 编码器库，它提供了高效的视频编码功能。
  # --enable-libxavs2 \ AVS2 是中国国家音视频编码标准的第二版，xavs2 是其对应的开源编码器
  # --enable-libmfx \ libmfx-dev libmfx-gen-dev Intel gpu加速 暂时不需要，需要时可以升级libmfx-dev最新版本
  # --enable-libxavs \ libavs-dev AVS 是中国国家音视频编码标准，xavs 是其对应的开源编码器 有 --enable-libxavs2
  # --enable-libv4l2 \ 没有apt包
  # --enable-libuavs3d \ 没有apt包
  # --enable-libsvtav1 \ libsvtav1-dev 未解决
  # --enable-libshaderc \ 没有apt包
  #--enable-librist \ 没有apt包
  # --enable-librav1e \ 没有apt包 编译安装时找不到pkgconfig文件
  #--enable-libopencv \ libopencv-dev 未解决 编译安装时找不到pkgconfig文件
  #--enable-libklvanc \ 没有apt包
  #--enable-libopenh264 \ libopenh264-dev 不需要
  # make -j ${THREAD} test
  make -j ${THREAD} && make install
  
  if [ -e "/usr/local/bin/ffmpeg" ]; then
    echo "${CSUCCESS}FFmpeg installed successfully! ${CEND}"
  else
    echo "${CFAILURE}FFmpeg install failed, Please Contact the author! ${CEND}"
    kill -9 $$; exit 1;
  fi

  popd > /dev/null
  rm -rf ffmpeg-${ffmpeg_ver}
  popd > /dev/null
}

Uninstall_FFmpeg() {
  [ -e "/usr/bin/ffmpeg" ] && apt-get -y autoremove ffmpeg
  rm -rfv /usr/local/bin/ffmpeg
}

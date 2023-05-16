#!/bin/bash
#DOC https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
#Download https://ffmpeg.org/download.html#releases
#REPO https://github.com/FFmpeg/FFmpeg/tags
. ${oneinstack_dir}/include/multimedia/libvmaf.sh
Install_FFmpeg() {
  pushd ${oneinstack_dir}/src > /dev/null
  #  libiec61883-dev \
  # librabbitmq-dev \
  apt-get -y install \
  nasm \
  libchromaprint-dev \
  frei0r-plugins-dev \
  libgmp-dev \
  ladspa-sdk \
  libaom-dev \
  libass-dev \
  libbluray-dev \
  libbs2b-dev \
  libslang2-dev \
  libcaca-dev \
  libcdio-dev \
  libcodec2-dev \
  libdav1d-dev \
  libdavs2-dev \
  libdc1394-dev \
  libfdk-aac-dev \
  flite1-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgme-dev \
  libgsm1-dev \
  libjack-dev \
  libmp3lame-dev \
  libmysofa-dev \
  libopenjp2-7-dev \
  libopenmpt-dev \
  libopus-dev \
  librubberband-dev \
  libshine-dev \
  libsnappy-dev \
  libsoxr-dev \
  libspeex-dev \
  libsrt-openssl-dev \
  libssh-dev \
  libtheora-dev \
  libtwolame-dev \
  libvidstab-dev \
  libvorbis-dev \
  libvpx-dev \
  libwebp-dev \
  libx265-dev \
  libx264-dev \
  libxml2-dev \
  libxvidcore-dev \
  libzimg-dev \
  libzmq5-dev \
  libzvbi-dev \
  liblilv-dev \
  libomxil-bellagio-dev \
  libopenal-dev \
  ocl-icd-opencl-dev \
  libopengl-dev \
  libsdl2-dev \
  libpocketsphinx-dev \
  librsvg2-dev \
  libmfx-dev \
  libmfx-gen-dev \
  libdrm-dev \
  librtmp-dev

  Install_Libvmaf

  src_url=https://ffmpeg.org/releases/ffmpeg-${ffmpeg_ver}.tar.xz && Download_src
  tar -xJf ffmpeg-${ffmpeg_ver}.tar.xz
  pushd ffmpeg-${ffmpeg_ver} > /dev/null
  #--enable-libiec61883 \
  # --enable-librabbitmq \
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
  --enable-libjack \
  --enable-libmp3lame \
  --enable-libmysofa \
  --enable-libopenjpeg \
  --enable-libopenmpt \
  --enable-libopus \
  --enable-libpulse \
  --enable-librubberband \
  --enable-libshine \
  --enable-libsnappy \
  --enable-libsoxr \
  --enable-libspeex \
  --enable-libsrt \
  --enable-libssh \
  --enable-libtheora \
  --enable-libtwolame \
  --enable-libvidstab \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libwebp \
  --enable-libx265 \
  --enable-libx264 \
  --enable-libxml2 \
  --enable-libxvid \
  --enable-libzimg \
  --enable-libzmq \
  --enable-libzvbi \
  --enable-lv2 \
  --enable-omx \
  --enable-openal \
  --enable-opencl \
  --enable-opengl \
  --enable-sdl2 \
  --enable-pocketsphinx \
  --enable-librsvg \
  --enable-libmfx \
  --enable-libdrm \
  --enable-librtmp \
  --enable-libvmaf
  #make -j ${THREAD} test
  make -j ${THREAD} && make install
  popd > /dev/null
  rm -rf ffmpeg-${ffmpeg_ver}
}

Uninstall_FFmpeg() {
  rm -rfv /usr/local/bin/ffmpeg
  Uninstall_Libvmaf
  apt-get remove nasm \
  libchromaprint-dev \
  frei0r-plugins-dev \
  libgmp-dev \
  ladspa-sdk \
  libaom-dev \
  libass-dev \
  libbluray-dev \
  libbs2b-dev \
  libslang2-dev \
  libcaca-dev \
  libcdio-dev \
  libcodec2-dev \
  libdav1d-dev \
  libdavs2-dev \
  libdc1394-dev \
  libfdk-aac-dev \
  flite1-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgme-dev \
  libgsm1-dev \
  libjack-dev \
  libmp3lame-dev \
  libmysofa-dev \
  libopenjp2-7-dev \
  libopenmpt-dev \
  libopus-dev \
  librubberband-dev \
  libshine-dev \
  libsnappy-dev \
  libsoxr-dev \
  libspeex-dev \
  libsrt-openssl-dev \
  libssh-dev \
  libtheora-dev \
  libtwolame-dev \
  libvidstab-dev \
  libvorbis-dev \
  libvpx-dev \
  libwebp-dev \
  libx265-dev \
  libx264-dev \
  libxml2-dev \
  libxvidcore-dev \
  libzimg-dev \
  libzmq5-dev \
  libzvbi-dev \
  liblilv-dev \
  libomxil-bellagio-dev \
  libopenal-dev \
  ocl-icd-opencl-dev \
  libopengl-dev \
  libsdl2-dev \
  libpocketsphinx-dev \
  librsvg2-dev \
  libmfx-dev \
  libmfx-gen-dev \
  libdrm-dev \
  librtmp-dev
}

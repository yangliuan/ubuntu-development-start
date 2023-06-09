#!/bin/bash
#DOC https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
#Download https://ffmpeg.org/download.html#releases
#REPO https://github.com/FFmpeg/FFmpeg/tags
#libavcodec58 libavdevice58 libavfilter7 libavfilter-extra7 libavformat-extra58 libavformat58 libavutil56 libc6 libpostproc55 libsdl2-2.0-0 libswresample3 libswscale5
 
Install_FFmpeg() {
  pushd ${ubdevenv_dir}/src > /dev/null
  [ -e "/usr/bin/ffmpeg" ] && apt-get -y autoremove ffmpeg

  UbuntuPkgList="${FFmpegDeps}" && installDepsUbuntu

  . ${ubdevenv_dir}/devbase/multimedia/libvmaf.sh
  Install_Libvmaf

  src_url=https://ffmpeg.org/releases/ffmpeg-${ffmpeg_ver}.tar.xz && Download_src
  tar -xJf ffmpeg-${ffmpeg_ver}.tar.xz
  pushd ffmpeg-${ffmpeg_ver} > /dev/null
  export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/
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
  --enable-libiec61883 \
  --enable-librtmp \
  --enable-libvmaf
  #make -j ${THREAD} test
  make -j ${THREAD} && make install
  popd > /dev/null
  rm -rf ffmpeg-${ffmpeg_ver}
}

Uninstall_FFmpeg() {
  [ -e "/usr/bin/ffmpeg" ] && apt-get -y autoremove ffmpeg
  rm -rfv /usr/local/bin/ffmpeg
}

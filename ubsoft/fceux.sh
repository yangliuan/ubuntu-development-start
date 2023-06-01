#!/bin/bash
#https://askubuntu.com/questions/1454137/how-do-i-fix-missing-dependencies-when-installing-fceux
Install_Fceux() {
    sudo apt-get install git cmake build-essential qtbase5-dev pkg-config zlib1g-dev libminizip-dev libsdl2-dev liblua5.1-dev qttools5-dev libx264-dev libx265-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libswresample-dev cppcheck

    pushd ${ubdevenv_dir}/src > /dev/null
    if [ ! -e "fceux-2.6.5.tar.gz" ]; then
        src_url="https://github.com/TASEmulators/fceux/archive/refs/tags/v2.6.5.tar.gz" && Download_src
        mv v2.6.5.tar.gz fceux-2.6.5.tar.gz
    fi
    
    tar -zxvf fceux-2.6.5.tar.gz
    pushd fceux-2.6.5  > /dev/null
    ./scripts/unix_make_docs.sh
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
    make -j ${THREAD} && make install
    popd > /dev/null

    if [ -e "/usr/bin/fceux" ]; then
        echo "${CSUCCESS}Fceux installed successfully! ${CEND}"
        rm -rf fceux-2.6.5
    else
        echo "${CFAILURE}Fceux install failed, Please Contact the author! ${CEND}"
        kill -9 $$; exit 1;
    fi

    popd > /dev/null
}

Uninstall_Fceux() {
    rm -rf /usr/bin/fceux /usr/share/fceux /usr/share/applications/fceux.desktop
}
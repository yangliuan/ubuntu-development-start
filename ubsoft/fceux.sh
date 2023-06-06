#!/bin/bash
#https://askubuntu.com/questions/1454137/how-do-i-fix-missing-dependencies-when-installing-fceux
fceux_deps="qtbase5-dev zlib1g-dev libminizip-dev libsdl2-dev liblua5.1-dev qttools5-dev libx264-dev libx265-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libswresample-dev cppcheck"

Install_Fceux() {
    pushd ${ubdevenv_dir}/src > /dev/null

    for fceux_dep in ${fceux_deps}; do
        apt-get install -y ${fceux_dep}
    done

    if [ ! -e "fceux-${fceux_ver}.tar.gz" ]; then
        src_url="https://github.com/TASEmulators/fceux/archive/refs/tags/v${fceux_ver}.tar.gz" && Download_src
        mv v${fceux_ver}.tar.gz fceux-${fceux_ver}.tar.gz
    fi
    
    tar -zxvf fceux-${fceux_ver}.tar.gz
    pushd fceux-${fceux_ver}  > /dev/null
    
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
    make -j ${THREAD} && make install
    popd > /dev/null

    if [ -e "/usr/bin/fceux" ]; then
        echo "${CSUCCESS}Fceux installed successfully! ${CEND}"
    else
        echo "${CFAILURE}Fceux install failed, Please Contact the author! ${CEND}"
        kill -9 $$; exit 1;
    fi

    rm -rf fceux-${fceux_ver}
    popd > /dev/null
}

Uninstall_Fceux() {
    rm -rf /usr/bin/fceux /usr/share/fceux /usr/share/applications/fceux.desktop

    for fceux_dep in ${fceux_deps}; do
        apt-get remove -y ${fceux_dep}
    done
}
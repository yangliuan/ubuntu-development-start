#!/bin/bash
#https://askubuntu.com/questions/1454137/how-do-i-fix-missing-dependencies-when-installing-fceux
Install_Fceux() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null
    if [ -e "fceux-${fceux_ver}-${SYS_ARCH}.deb" ]; then
        dpkg -i fceux-${fceux_ver}-${SYS_ARCH}.deb
        apt-get install -f -y
    else
        #It is recommended to build it separately in the virtual machine   
        Build_Fceux_Deb
    fi
    popd > /dev/null
}

Uninstall_Fceux() {
    dpkg -P fceux
}

#It is recommended to build it separately in the virtual machine to avoid installing unnecessary packages and link inventory issues
Build_Fceux_Deb() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null
    if [ ! -e "fceux-${fceux_ver}.tar.gz" ]; then
        src_url="https://github.com/TASEmulators/fceux/archive/refs/tags/v${fceux_ver}.tar.gz" && Download_src
        mv v${fceux_ver}.tar.gz fceux-${fceux_ver}.tar.gz
    fi

    tar -zxvf fceux-${fceux_ver}.tar.gz
        pushd fceux-${fceux_ver} > /dev/null
        #dont make doc
        #sed -i "s#./scripts/unix_make_docs.sh;##g" linux_build.sh
        cp -fv CMakeLists.txt ./pipelines/
        . ./pipelines/linux_build.sh
        cp -fv /tmp/fceux-${fceux_ver}-${SYS_ARCH}.deb ${ubdevenv_dir}/src
        popd > /dev/null
    rm -rf fceux-${fceux_ver}
    popd > /dev/null
}
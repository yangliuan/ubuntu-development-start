#!/bin/bash
Install_By_Complie() {
    pushd ${oneinstack_dir}/src > /dev/null
    pkgList="gcc dialog libaugeas0 augeas-lenses libssl-dev libffi-dev ca-certificates"
    for Package in ${pkgList}; do
      apt-get -y install $Package
    done
  
    # Downlaod Python3
    src_url=https://www.python.org/ftp/python/${python_ver}/Python-${python_ver}.tgz && Download_src
    tar xzf Python-${python_ver}.tgz
    pushd Python-${python_ver} > /dev/null
    ./configure --prefix=${python_install_dir} --enable-optimizations
    make -j ${THREAD} && make install
    [ ! -e "${python_install_dir}/bin/python" -a -e "${python_install_dir}/bin/python3" ] && ln -s ${python_install_dir}/bin/python{3,}
    [ ! -e "${python_install_dir}/bin/pip" -a -e "${python_install_dir}/bin/pip3" ] && ln -s ${python_install_dir}/bin/pip{3,}
    popd > /dev/null
    
    if [ -d "${python_install_dir}/bin" ]; then
      echo "${CSUCCESS} Python${python_ver} installed  successfully! ${CEND}"
      rm -rf Python-${python_ver}
    fi
    popd > /dev/null
}

Uninstall_Complie_Python3() {
    rm -rf ${python_install_dir}
}

Instwaall_By_Deadsnakes() {
    add-apt-repository ppa:deadsnakes/ppa
    apt-get update
    #ubuntu22.04 default 
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
    snake_version=([4]=3.8 [3]=3.9 [2]=3.11)
    
    for current_version in ${snake_version}; do
      apt-get -y install "python$current_version"
      update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 ${!snake_version[@]}
    done
}

Uninstall_By_Deadsnakes() {
    update-alternatives --remove-all python3
    for current_version in ${snake_version}; do
      apt-get -y autoremove "python$current_version"
    done
    add-apt-repository -r ppa:deadsnakes/ppa
}

#https://developer.aliyun.com/mirror/pypi Mirror Page
Install_Cn_Mirror() {
    #set run user china mirrors
    if [ ! -e "/home/${run_user}/.pip/pip.conf" ] ;then
      if [ "${OUTIP_STATE}"x == "China"x ]; then
        [ ! -d "/home/${run_user}/.pip" ] && mkdir /home/${run_user}/.pip
          cat > /home/${run_user}/.pip/pip.conf << EOF
[global]
index-url=https://mirrors.cloud.aliyuncs.com/pypi/simple/

[install]
trusted-host=mirrors.cloud.aliyuncs.com
EOF
      fi
    fi
}

Uninstall_Cn_Mirror() {
    rm -rf /home/${run_user}/.pip/pip.conf
}
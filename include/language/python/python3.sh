#!/bin/bash
Upgrade_Python3() {
    pushd ${oneinstack_dir}/src > /dev/null
    pkgList="gcc dialog libaugeas0 augeas-lenses libssl-dev libffi-dev ca-certificates"
    for Package in ${pkgList}; do
      apt-get -y install $Package
    done
  
    # Upgrade Python3
    src_url=https://www.python.org/ftp/python/${python_ver}/Python-${python_ver}.tgz && Download_src
    tar xzf Python-${python_ver}.tgz
    pushd Python-${python_ver} > /dev/null
    ./configure
    make -j ${THREAD} && make install
    popd > /dev/null
    
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

    current_python_ver=$(python3 -V)
    if [ "${current_python_ver}" == "Python ${python_ver}" ]; then
      echo "${CSUCCESS}Upgrade system python3 successfully! ${CEND}"
      rm -rf Python-${python_ver}
    fi
    popd > /dev/null
}

#waring ubuntu-desktop need python3 for run
Uninstall_Old() {
  pushd /usr/bin/ > /dev/null
  rm -rf py3clean py3compile py3versions pydoc3 pydoc3.10 pygettext3 pygettext3.10 python3 python3.10  python3.10-config python3-config python3-futurize python3-pasteurize pythran pythran-config
  popd > /dev/null
  rm -rf /user/share/python3 /user/share/python3-apt /user/include/python3.10
  rm -rf /usr/lib/python3 /usr/lib/python3.10 /usr/lib/python3.11 /user/local/lib/python3.10
}

#!/bin/bash
#DOC:https://github.com/nvm-sh/nvm#git-install
Install_Nvm() {
    pushd ${ubdevenv_dir}/src > /dev/null
    if [ ! -e "nvm-${nvm_ver}.tar.gz" ]; then
        src_url=https://github.com/nvm-sh/nvm/archive/refs/tags/v${nvm_ver}.tar.gz && Download_src
        mv v${nvm_ver}.tar.gz nvm-${nvm_ver}.tar.gz
    fi
    
    tar -zxvf nvm-${nvm_ver}.tar.gz
    mv -fv nvm-${nvm_ver} ${nvm_install_dir}
    chown -Rv ${run_user}.${run_user} ${nvm_install_dir}

    if [ -e "${nvm_install_dir}/nvm.sh" ]; then
        echo "${CSUCCESS}Nvm installed successfully! ${CEND}"
    else
        echo "${CFAILURE}Nvm install failed, Please contact the author! ${CEND}" && lsb_release -a
        kill -9 $$; exit 1;
    fi 
    
    cat >> /home/${run_user}/.bashrc <<EOF
export NVM_DIR="${nvm_install_dir}" ###nvm
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh" ###nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion" ###nvm
EOF
    source /home/${run_user}/.bashrc

    if [ ! -e "/home/${run_user}/.npmrc" ];then
        touch /home/${run_user}/.npmrc
        chown -R ${run_user}.${run_user} /home/${run_user}/.npmrc
        cat >> /home/${run_user}/.npmrc <<EOF
registry=https://registry.npmmirror.com/
electron-mirror=https://registry.npmmirror.com/binary.html?path=electron/
EOF
    fi
    popd > /dev/null
}

Uninstall_Nvm(){
    #delete env
    sed -i '/##nvm$/d' /home/${run_user}/.bashrc
    rm -rfv ${nvm_install_dir} /home/${run_user}/.npm /home/${run_user}/.npmrc
}

#electron build .exe application need wine  
Install_Wine() {
    apt-get -y install wine
}

Uninstall_Wine() {
    apt-get -y autoremove wine
}
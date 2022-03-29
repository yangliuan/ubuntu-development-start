#!/bin/bash
Install_Nvm(){
    #DOC:https://github.com/nvm-sh/nvm#git-install
    pushd /home/${run_user}/ > /dev/null
    
    if [ ! -e "/usr/bin/git" ]; then
        sudo apt-get install git
    fi

    sudo -u ${run_user} git clone -b v${nvm_ver} --depth=1 https://github.com/nvm-sh/nvm.git .nvm
    #add command
    cat >> /home/${run_user}/.bashrc <<EOF
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"
EOF

    source /etc/bash.bashrc
    popd > /dev/null
}

Uninstall_Nvm(){
    rm -rf /home/${run_user}/.nvm
    sed -i "s/[ -s "$NVM_DIR\/nvm.sh" ]//g" /home/${run_user}/.bashrc
    sed -i "s/xtNVMDIRHOME//g" /home/${run_user}/.bashrc
    sed -i "s/NVMDIRNVMDIR//g" /home/${run_user}/.bashrc
    sed -i "s/NVMDIRtNVMDIRt//g" /home/${run_user}/.bashrc
}   
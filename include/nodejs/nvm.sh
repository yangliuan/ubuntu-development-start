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
###nvm
export NVM_DIR="\$HOME/.nvm" ###nvm
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh" ###nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion" ###nvm
EOF
    source /home/${run_user}/.bashrc
    popd > /dev/null
}

Uninstall_Nvm(){
    #delete env
    sed -i '/##nvm$/d' /home/${run_user}/.bashrc
    source /home/${run_user}/.bashrc
    rm -rf /home/${run_user}/.nvm /home/${run_user}/.npm
}

Install_Wine() {
    apt install wine
}
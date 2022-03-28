#!/bin/bash
Install_Nvm(){
    #DOC:https://github.com/nvm-sh/nvm#git-install
    pushd /home/${run_user}/ > /dev/null

    sudo -u ${run_user} git clone -b v${nvm_ver} git@github.com:nvm-sh/nvm.git .nvm
    #add command
    cat >> /home/${run_user}/.bashrc <<EOF
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

    source /etc/bash.bashrc
    popd > /dev/null
}

Uninstall_Nvm(){
    rm -rf /home/${run_user}/.nvm
}   
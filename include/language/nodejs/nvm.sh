#!/bin/bash
Install_Nvm() {
    #DOC:https://github.com/nvm-sh/nvm#git-install
    pushd ${oneinstack_dir}/src > /dev/null
    src_url=http://mirror.yangliuan.cn/nvm-${nvm_ver}.tar.gz && Download_src
    tar -zxvf nvm-${nvm_ver}.tar.gz
    mv -rfv nvm-${nvm_ver} ${nvm_install_dir}
    #add env
    cat >> /etc/profile.d/nvm.sh <<EOF
export NVM_DIR="${nvm_install_dir}" ###nvm
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh" ###nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion" ###nvm
EOF
    source /etc/profile.d/nvm.sh
    popd > /dev/null
}

Uninstall_Nvm(){
    #delete env
    rm -rf /home/${run_user}/.nvm /home/${run_user}/.npm /etc/profile.d/nvm.sh
}

Install_Wine() {
    apt install wine
}
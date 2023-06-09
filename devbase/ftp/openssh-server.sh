#!/bin/bash
Install_OpensshServer(){
    apt-get -y install openssh-server
    #修改配置文件允许root远程登录
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
    systemctl disable ssh.service
    systemctl start ssh.service
}

Uninstall_OpensshServer(){
    apt-get autoremove -y openssh-server
}
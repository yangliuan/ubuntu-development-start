Install_OpensshServer(){
    apt-get install openssh-server
    ufw allow ssh
    #修改配置文件允许root远程登录
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
    service sshd start
    service sshd status
}

Uninstall_OpensshServer(){
    apt-get autoremove openssh-server
}
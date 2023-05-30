#!/bin/bash
#erlang版本支持对照https://rabbitmq.com/which-erlang.html
#二进制包安装　https://rabbitmq.com/install-generic-unix.html
#https://rabbitmq.com/devtools.html
Install_RabbitMQ() {
    pushd ${ubdevenv_dir}/src > /dev/null
    src_url="https://github.com/rabbitmq/rabbitmq-server/releases/download/v${rabbitmq_ver}/rabbitmq-server-generic-unix-${rabbitmq_ver}.tar.xz" && Download_src
    echo "Download rabbitmq ..."
    tar xJf rabbitmq-server-generic-unix-${rabbitmq_ver}.tar.xz
    mv -fv rabbitmq_server-${rabbitmq_ver} ${rabbitmq_install_dir}

    #创建用户
    id -u rabbitmq >/dev/null 2>&1
    [ $? -ne 0 ] && useradd -M -s /sbin/nologin rabbitmq

    #使用指定用户运行服务时，需要创建用户家目录，用于.erlang.cookie和权限问题
    if [ ! -d "/home/rabbitmq" ]; then
        mkdir -p /home/rabbitmq
        chown -R rabbitmq.rabbitmq /home/rabbitmq
    fi

    /bin/cp -rfv ../config/rabbitmq.conf ${rabbitmq_install_dir}/etc/rabbitmq
    chown -R rabbitmq.rabbitmq ${rabbitmq_install_dir}

    #更新systemed
    /bin/cp -rfv ${ubdevenv_dir}/init.d/rabbitmq-server.service /lib/systemd/system
    sed -i "s@/usr/local/rabbitmq@${rabbitmq_install_dir}@g" /lib/systemd/system/rabbitmq-server.service
    systemctl daemon-reload

    echo "rabbitmq install success!"
    popd > /dev/null
}

Uninstall_RabbitMQ(){
    userdel -rf rabbitmq
    groupdel rabbitmq
    rm -rfv ${rabbitmq_install_dir} /lib/systemd/system/rabbitmq-server.service /etc/profile.d/rabbitmq.sh
    systemctl daemon-reload
}


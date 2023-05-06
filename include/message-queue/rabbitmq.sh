#!/bin/bash
#erlang版本支持对照https://rabbitmq.com/which-erlang.html
Install_RabbitMQ() {
    pushd ${oneinstack_dir}/src > /dev/null
    src_url="https://github.com/rabbitmq/rabbitmq-server/releases/download/v${rabbitmq_ver}/rabbitmq-server-generic-unix-${rabbitmq_ver}.tar.xz" && Download_src
    echo "Download rabbitmq ..."
    tar xJf rabbitmq-server-generic-unix-${rabbitmq_ver}.tar.xz
    mv -fv rabbitmq_server-${rabbitmq_ver} ${rabbitmq_install_dir}

    #创建用户
    id -g rabbitmq >/dev/null 2>&1
    [ $? -ne 0 ] && groupadd rabbitmq
    id -u rabbitmq >/dev/null 2>&1
    [ $? -ne 0 ] && useradd -g rabbitmq -M -s /sbin/nologin rabbitmq

    if [ ! -d "/home/rabbitmq"];then
        mkdir -p rabbitmq
        chown -R rabbitmq.rabbitmq /home/rabbitmq
    fi
    
    #更新systemed
    chown -R rabbitmq.rabbitmq ${rabbitmq_install_dir}
    /bin/cp -rfv ${oneinstack_dir}/init.d/rabbitmq-server.service /lib/systemd/system
    systemctl daemon-reload

    echo "rabbitmq install success!"
    popd > /dev/null
}

Uninstall_RabbitMQ(){
    if [ -d "${rabbitmq_install_dir}" ]; then
        rm -rfv ${rabbitmq_install_dir} /lib/systemd/system/rabbitmq-server.service
        systemctl daemon-reload
    fi
}


#!/bin/bash
#erlang版本支持对照https://rabbitmq.com/which-erlang.html
Install_RabbitMQ(){
    pushd ${oneinstack_dir}/src > /dev/null
    src_url="https://github.com/rabbitmq/rabbitmq-server/releases/download/v${rabbitmq_ver}/rabbitmq-server-generic-unix-${rabbitmq_ver}.tar.xz" && Download_src
    echo "Download rabbitmq ..."
    xz -d rabbitmq-server-generic-unix-${rabbitmq_ver}.tar.xz
    tar -xvf rabbitmq-server-generic-unix-${rabbitmq_ver}
    cp -r rabbitmq-server-generic-unix-${rabbitmq_ver} ${rabbitmq_install_dir}
}

Uninstall_RabbitMQ(){
    echo 'uninstall rabbitmq';
}
#!/bin/bash

Install_Kafka() {
    pushd ${oneinstack_dir}/src > /dev/null

    echo "Download kafka ..."
    src_url="https://dlcdn.apache.org/kafka/${kafka_scala_ver}/kafka_${kafka_ver}-${kafka_scala_ver}.tgz" && Download_src
    tar xzf kafka_${kafka_ver}-${kafka_scala_ver}.tgz
    mv kafka_${kafka_ver}-${kafka_scala_ver} ${kafka_install_dir}
    sed -i "s#/tmp/zookeeper#${zookeeper_data_dir}#g" ${kafka_install_dir}
    
    id -u kafka >/dev/null 2>&1
    [ $? -ne 0 ] && useradd -M -s /sbin/nologin redis

    cp zookeeper.service /lib/systemd/system/
    cp kafka.service /lib/systemd/system/
    systemctl daemon-reload
    systemctl start zookeeper.service 
    systemctl start kafka.service
}

Uninstall_Kafka() {
    rm -rf ${kafka_install_dir}
    rm -rf /lib/systemd/system/zookeeper.service
    rm -rf /lib/systemd/system/kafka.service
    systemctl daemon-reload
}
#!/bin/bash
# DOC https://kafka.apachecn.org/quickstart.html
# DOC https://kafka.apache.org/30/documentation.html#quickstart
Install_Kafka() {
    pushd ${oneinstack_dir}/src > /dev/null

    echo "Download kafka ..."
    src_url="https://dlcdn.apache.org/kafka/${kafka_scala_ver}/kafka_${kafka_ver}-${kafka_scala_ver}.tgz" && Download_src
    tar xzf kafka_${kafka_ver}-${kafka_scala_ver}.tgz
    mv kafka_${kafka_ver}-${kafka_scala_ver} ${kafka_install_dir}
    sed -i "s#/tmp/zookeeper#${zookeeper_data_dir}#g" ${kafka_install_dir}/config/zookeeper.properties
    sed -i "s/#advertised.listeners=PLAINTEXT:\/\/your.host.name:9092/advertised.listeners=PLAINTEXT:\/\/127.0.0.1:9092/g" ${kafka_install_dir}/config/server.properties
    sed -i "s#/tmp/kafka-logs#${kafka_data_dir}#g" ${kafka_install_dir}/config/server.properties

    id -u kafka >/dev/null 2>&1
    [ $? -ne 0 ] && useradd -M -s /sbin/nologin kafka

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
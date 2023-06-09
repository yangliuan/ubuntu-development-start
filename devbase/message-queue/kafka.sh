#!/bin/bash
# DOC https://kafka.apachecn.org/quickstart.html
# DOC https://kafka.apache.org/30/documentation.html#quickstart
# DOC https://kafka.apache.org/downloads
Install_Kafka() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download kafka ..."
    src_url="https://dlcdn.apache.org/kafka/${kafka_ver}/kafka_${kafka_scala_ver}-${kafka_ver}.tgz" && Download_src
    tar xzf kafka_${kafka_scala_ver}-${kafka_ver}.tgz
    sed -i "s#/tmp/zookeeper#${zookeeper_data_dir}#g" kafka_${kafka_scala_ver}-${kafka_ver}/config/zookeeper.properties
    sed -i "s/#advertised.listeners=PLAINTEXT:\/\/your.host.name:9092/advertised.listeners=PLAINTEXT:\/\/127.0.0.1:9092/g" kafka_${kafka_scala_ver}-${kafka_ver}/config/server.properties
    sed -i "s#/tmp/kafka-logs#${kafka_data_dir}#g" kafka_${kafka_scala_ver}-${kafka_ver}/config/server.properties
    mv kafka_${kafka_scala_ver}-${kafka_ver} ${kafka_install_dir}

    if [ ! -d "${zookeeper_data_dir}" ]; then
        mkdir -p ${zookeeper_data_dir}
    fi

    if [ ! -d "${kafka_data_dir}" ]; then
        mkdir -p ${kafka_data_dir}
    fi

    id -u kafka >/dev/null 2>&1
    [ $? -ne 0 ] && useradd -M -s /sbin/nologin kafka
    chown -R kafka.kafka ${kafka_install_dir} ${zookeeper_data_dir} ${kafka_data_dir}
    chmod -R 755 ${kafka_install_dir} ${zookeeper_data_dir} ${kafka_data_dir}
    
    cp ${ubdevenv_dir}/init.d/zookeeper-inkafka.service /lib/systemd/system/
    cp ${ubdevenv_dir}/init.d/kafka.service /lib/systemd/system/
    sed -i "s@/usr/local/kafka@${kafka_install_dir}@g" /lib/systemd/system/zookeeper-inkafka.service
    sed -i "s@/usr/local/kafka@${kafka_install_dir}@g" /lib/systemd/system/kafka.service
    systemctl daemon-reload
    
    echo "${CSUCCESS}Kafka installed successfully! ${CEND}"
    popd > /dev/null
}

Uninstall_Kafka() {
    if [ -d "${kafka_install_dir}" ]; then
        rm -rf ${kafka_install_dir}
        rm -rf /lib/systemd/system/zookeeper-inkafka.service
        rm -rf /lib/systemd/system/kafka.service
        systemctl daemon-reload
    fi
}
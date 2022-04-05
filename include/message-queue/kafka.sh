#!/bin/bash

Install_Kafka() {
    pushd ${oneinstack_dir}/src > /dev/null

    echo "Download kafka ..."
    src_url="https://dlcdn.apache.org/kafka/${kafka_scala_ver}/kafka_${kafka_ver}-${kafka_scala_ver}.tgz" && Download_src
    tar xzf kafka_${kafka_ver}-${kafka_scala_ver}.tgz
    mv kafka_${kafka_ver}-${kafka_scala_ver} ${kafka_install_dir}
    sed -i "s#/tmp/zookeeper#${zookeeper_data_dir}#g" ${kafka_install_dir}
    
}

Uninstall_Kafka() {
    
}
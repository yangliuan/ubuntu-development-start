#!/bin/bash
#https://www.elastic.co/guide/en/elasticsearch/reference/
Install_ElasticStack() {
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

    if [ "${OUTIP_STATE}"x == "China"x ]; then
        elasticstack_mirrors="https://mirrors.aliyun.com/elasticstack/apt/${elasticsearch_ver}"
    else
        elasticstack_mirrors="https://artifacts.elastic.co/packages/${elasticsearch_ver}/apt"
    fi
    
    echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] ${elasticstack_mirrors} stable main" | tee /etc/apt/sources.list.d/elastic-${elasticsearch_ver}.list
    apt-get update
    Install_ElasticSearch
    Install_Kibana
    Install_Logstash
    Install_Beats
    Install_Cerebro
}

Install_ElasticSearch() {
    pushd ${ubdevenv_dir}/src > /dev/null
    #apt-get -y install elasticsearch
    [ ! -e "elasticsearch_8.8.0_amd64.deb" ] && apt-get download -y elasticsearch
    dpkg -i elasticsearch_8.8.0_amd64.deb
    popd > /dev/null
}

Install_Kibana() {
    pushd ${ubdevenv_dir}/src > /dev/null
    #apt-get -y install kibana
    [ ! -e "kibana_8.8.0_amd64.deb" ] && apt-get download -y kibana
    dpkg -i kibana_8.8.0_amd64.deb
    popd > /dev/null
}

Install_Logstash() {
    pushd ${ubdevenv_dir}/src > /dev/null
    #apt-get -y install logstash
    [ ! -e "logstash_1%3a8.8.0-1_amd64.deb" ] && apt-get download -y logstash
    dpkg -i logstash_1%3a8.8.0-1_amd64.deb
    popd > /dev/null
}

Install_Beats() {
    pushd ${ubdevenv_dir}/src > /dev/null
    #apt-get install -y filebeat
    [ ! -e "filebeat_8.8.0_amd64.deb" ] && apt-get download -y filebeat
    dpkg -i filebeat_8.8.0_amd64.deb
    
    #apt-get install -y packetbeat
    [ ! -e "packetbeat_8.8.0_amd64.deb" ] && apt-get download -y packetbeat
    dpkg -i packetbeat_8.8.0_amd64.deb

    #apt-get install -y metricbeat
    [ ! -e "metricbeat_8.8.0_amd64.deb" ] && apt-get download -y metricbeat-elastic
    dpkg -i metricbeat_8.8.0_amd64.deb

    #apt-get install -y heartbeat-elastic
    [ ! -e "heartbeat-elastic_8.8.0_amd64.deb" ] && apt-get download -y heartbeat-elastic
    dpkg -i heartbeat-elastic_8.8.0_amd64.deb

    #apt-get install -y auditbeat
    [ ! -e "auditbeat_8.8.0_amd64.deb" ] && apt-get download -y auditbeat
    dpkg -i auditbeat_8.8.0_amd64.deb
    popd > /dev/null
}

Install_Cerebro() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download cerebro ..."
    src_url="http://mirror.yangliuan.cn/cerebro-${cerebo_ver}.tgz" && Download_src
    tar zxvf cerebro-${cerebo_ver}.tgz
    mkdir /etc/cerebro
    cp -r cerebro-${cerebo_ver}/conf/* /etc/cerebro
    mv cerebro-${cerebo_ver} /usr/share/cerebro
    #create group and user
    id -g cerebro >/dev/null 2>&1
    [ $? -ne 0 ] && groupadd cerebro
    id -u cerebro >/dev/null 2>&1
    [ $? -ne 0 ] && useradd -g cerebro -M -s /sbin/nologin cerebro
    #created systemd cerebro.service
    cp ${ubdevenv_dir}/init.d/cerebro.service /lib/systemd/system/
    chown -R cerebro.cerebro /usr/share/cerebro
    systemctl daemon-reload
    popd > /dev/null
}

Install_Config() {
    chmod -R 777 /etc/elasticsearch
    sed -i "s/## -Xms4g/-Xms1g/g" /etc/elasticsearch/jvm.options
    sed -i "s/## -Xmx4g/-Xmx1g/g" /etc/elasticsearch/jvm.options
}

Uninstall_ElasticStack() {
    apt-get -y purge elasticsearch kibana logstash
    rm -rfv /etc/apt/sources.list.d/elastic-${elasticsearch_ver}.list
    rm -rfv /etc/apt/sources.list.d/elastic-${elasticsearch_ver}.list.save
    rm -rfv /usr/share/keyrings/elasticsearch-keyring.gpg
    apt-get update
    Uninsall_EleasticSearch
    Uninstall_Kibana
    Uninstall_logstash
    Uninstall_beats
    Uninstall_Cerebro
}

Uninsall_EleasticSearch() {
    apt-get autoremove -y elasticsearch
}

Uninstall_Kibana() {
    apt-get autoremove -y kibana
}

Uninstall_logstash() {
    apt-get autoremove -y logstash
}

Uninstall_beats() {
    apt-get autoremove -y filebeat heartbeat-elastic packetbeat
}

Uninstall_Cerebro() {
    rm -rfv /lib/systemd/system/cerebro.service
    rm -rfv /usr/share/cerebro /etc/cerebro
    systemctl daemon-reload
}


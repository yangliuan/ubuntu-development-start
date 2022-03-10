#!/bin/bash
Install_Elasticsearch() {
    if [ "${PM}" == "yum" ]; then
      if [ ! -e "/etc/yum.repos.d/elasticsearch.repo" ]; then
        cat > /etc/yum.repos.d/elasticsearch.repo <<EOF
[elasticsearch]
name=Elasticsearch repository for ${elasticsearch_ver} packages
baseurl=https://artifacts.elastic.co/packages/${elasticsearch_ver}/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md
EOF
      fi
        yum install --enablerepo=elasticsearch elasticsearch && yum install --enablerepo=elasticsearch kibana
        pushd ${oneinstack_dir}/src > /dev/null
        echo "Download cerebo ..."
        src_url="http://mirror.yangliuan.cn/cerebro-${cerebo_ver}-1.noarch.rpm" && Download_src
        rpm -ivh cerebro-${cerebo_ver}-1.noarch.rpm
    elif [ "${PM}" == "apt-get" ]; then
        wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
        apt-get install apt-transport-https
        echo "deb https://artifacts.elastic.co/packages/${elasticsearch_ver}/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-${elasticsearch_ver}.list
        apt-get update && apt-get install elasticsearch && apt-get install kibana
        pushd ${oneinstack_dir}/src > /dev/null
        echo "Download cerebo ..."
        src_url="http://mirror.yangliuan.cn/cerebro_${cerebo_ver}_all.deb" && Download_src
        dpkg -i cerebro_${cerebo_ver}_all.deb
    fi
}

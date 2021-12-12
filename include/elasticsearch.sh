#!/bin/bash
Install_Elasticsearch() {
    if [ "${PM}" == "yum" ]; then
      if [ ! -e "/etc/yum.repos.d/elasticsearch.repo" ]; then
        cat > /etc/yum.repos.d/elasticsearch.repo <<EOF
[elasticsearch]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md
EOF
      fi
        yum install --enablerepo=elasticsearch elasticsearch && yum install kibana
    elif [ "${PM}" == "apt-get" ]; then
        wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
        apt-get install apt-transport-https
        echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
        apt-get update && sudo apt-get install elasticsearch && sudo apt-get install kibana
    fi
}

#!/bin/bash
Install_elasticsearch(){
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    sudo apt-get install apt-transport-https
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
    sudo apt-get update && sudo apt-get install elasticsearch
}
#未来改进
#1.选择是仓库安装方式还是软件包安装方式
#2.仓库安装方式直接安装，如果是软件包方式判断操作系统和cpu架构下载对应软件包
#3.安装kabana certlog
#!/bin/bash
Set_Aliyun_Sourcelist() {
    cp -r /etc/apt/sources.list /etc/apt/sources.list.bk
    sed -i "s#http://cn.archive.ubuntu.com/ubuntu/#http://mirrors.aliyun.com/ubuntu/#g" /etc/apt/sources.list
    apt-get -y update && apt-get -y upgrade
}

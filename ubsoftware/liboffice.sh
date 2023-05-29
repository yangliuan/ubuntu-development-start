#!/bin/bash
Install_Libreoffice() {
    apt-get -y install libreoffice
}

Uninstall_Libreoffice(){
    #卸载自带的liboffice相关软件,不使用autoremove防止破坏其它软件依赖
    apt-get -y remove libreoffice 
    apt-get -y purge libreoffice
}
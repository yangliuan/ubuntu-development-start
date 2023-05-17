#!/bin/bash
Install_ObsStudio(){
    #DOC https://obsproject.com/wiki/install-instructions#linux-install-directions    
    apt-get -y install v4l2loopback-dkms
    add-apt-repository ppa:obsproject/obs-studio
    apt-get update
    apt-get -y install obs-studio
}

Unintall_ObsStudio() {
    apt-get -y remove obs-studio
    apt-get -y remove v4l2loopback-dkms
    rm -rfv /etc/apt/sources.list.d/obsproject-ubuntu-obs-studio-focal.list
    rm -rfv /etc/apt/sources.list.d/obsproject-ubuntu-obs-studio-focal.list.save
}
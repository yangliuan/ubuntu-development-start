#!/bin/bash
Install_ObsStudio(){
    #DOC https://obsproject.com/wiki/install-instructions#linux-install-directions
    if [ ! -e "/usr/bin/ffmpeg" ]; then
        apt-get install ffmpeg
    fi
    
    apt-get install v4l2loopback-dkms
    add-apt-repository ppa:obsproject/obs-studio
    apt-get update
    apt-get install obs-studio
}

Unintall_ObsStudio() {
    apt-get autoremove obs-studio
    apt-get autoremove v4l2loopback-dkms
    rm -rfv /etc/apt/sources.list.d/obsproject-ubuntu-obs-studio-focal.list
    rm -rfv /etc/apt/sources.list.d/obsproject-ubuntu-obs-studio-focal.list.save
}
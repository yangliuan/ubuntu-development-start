#!/bin/bash
#DOC https://obsproject.com/wiki/install-instructions#linux-install-directions    
Install_ObsStudio(){
    apt-get -y install v4l2loopback-dkms
    add-apt-repository ppa:obsproject/obs-studio
    apt-get update
    apt-get -y install obs-studio
}

Unintall_ObsStudio() {
    apt-get -y autoremove v4l2loopback-dkms
    add-apt-repository -r ppa:atareao/atareao
    apt-get update
    apt-get -y autoremove obs-studio
}
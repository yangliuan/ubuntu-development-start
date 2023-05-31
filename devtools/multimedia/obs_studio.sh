#!/bin/bash
#DOC https://obsproject.com/wiki/install-instructions#linux-install-directions    
Install_ObsStudio(){
    apt-get -y install v4l2loopback-dkms
    add-apt-repository -y ppa:obsproject/obs-studio
    apt-get update
    apt-get install -y obs-studio
    apt-get install -f
}

Unintall_ObsStudio() {
    apt-get -y autoremove v4l2loopback-dkms
    add-apt-repository -r -y ppa:atareao/atareao
    apt-get update
    apt-get -y autoremove obs-studio
}
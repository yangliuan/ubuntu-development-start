#!/bin/bash
Install_ObsStudio(){
    #DOC https://obsproject.com/wiki/install-instructions#linux-install-directions
    sudo apt install v4l2loopback-dkms
    sudo add-apt-repository ppa:obsproject/obs-studio
    sudo apt-get update
    sudo apt-get install obs-studio
}
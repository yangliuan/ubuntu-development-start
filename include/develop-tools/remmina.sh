#!/bin/bash
Install_Remmina(){
    killall remmina
    apt-add-repository ppa:remmina-ppa-team/remmina-next
    apt update
    apt install remmina remmina-plugin-rdp remmina-plugin-secret
}
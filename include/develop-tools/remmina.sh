#!/bin/bash
Install_Remmina() {
    killall remmina
    apt-add-repository -y ppa:remmina-ppa-team/remmina-next
    apt-get update
    apt-get -y install remmina remmina-plugin-rdp remmina-plugin-secret
}

Uninstall_Remmina() {
    apt-get -y autoremove remmina remmina-plugin-rdp remmina-plugin-secret
    apt-add-repository -y -r ppa:remmina-ppa-team/remmina-next
    apt-get update
}
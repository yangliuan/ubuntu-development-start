#!/bin/bash
Install_Remmina() {
    killall remmina
    apt-add-repository ppa:remmina-ppa-team/remmina-next
    apt-get update
    apt-get install remmina remmina-plugin-rdp remmina-plugin-secret
}

Unstall_Remmina() {
    apt-get autoremove remmina remmina-plugin-rdp remmina-plugin-secret
}
#!/bin/bash
Install_Wireshark() {
    add-apt-repository -y ppa:wireshark-dev/stable
    apt-get update
    apt-get -y install wireshark
}

Uninstall_Wireshark() {
    apt-get -y autoremove wireshark
    add-apt-repository -y -r ppa:wireshark-dev/stable
    apt-get update
}
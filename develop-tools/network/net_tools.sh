#!/bin/bash
Install_Net_Tools() {
    apt-get -y install net-tools
}

Uninstall_Net_Tools() {
    apt-get -y autoremove net-tools
}
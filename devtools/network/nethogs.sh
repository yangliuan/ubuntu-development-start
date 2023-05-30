#!/bin/bash
Install_Nethogs() {
    apt-get -y install nethogs
}

Uninstall_Nethogs() {
    apt-get -y autoremove nethogs
}
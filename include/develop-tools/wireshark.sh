#!/bin/bash
Install_Wireshark() {
    add-apt-repository ppa:wireshark-dev/stable
    apt-get update
    apt-get install wireshark
}

Unstall_Wireshark() {
    apt-get autoremove wireshark
    rm -rfv /etc/apt/sources.list.d/wireshark-dev-ubuntu-stable-focal.list
    rm -rfv /etc/apt/sources.list.d/wireshark-dev-ubuntu-stable-focal.list.save
}
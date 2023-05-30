#!/bin/bash
Install_Peek() {
    add-apt-repository -y ppa:peek-developers/stable
    apt-get update
    apt-get -y install peek
}

Uninstall_Peek() {
    apt-get -y autoremove peek
    add-apt-repository -y -r ppa:peek-developers/stable
    apt-get update
}
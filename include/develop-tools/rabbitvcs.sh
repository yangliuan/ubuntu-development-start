#!/bin/bash
#DOC http://wiki.rabbitvcs.org/wiki/install/ubuntu#installation-on-ubuntu
#https://installati.one/ubuntu/22.04/rabbitvcs-nautilus/
Install_Rabbitvcs() {
    # sudo add-apt-repository ppa:rabbitvcs/ppa
    # #Add the following line to your /etc/apt/sources.list file (signing key=1024R/34EF4A35):
    # [ -z "`grep ^'http://ppa.launchpad.net/rabbitvcs/ppa/ubuntu' /etc/apt/sources.list`" ] && echo "deb http://ppa.launchpad.net/rabbitvcs/ppa/ubuntu ${ubuntu_name} main" >> /etc/apt/sources.list
    # sudo apt-get update
    # sudo apt-get install rabbitvcs-nautilus rabbitvcs-thunar rabbitvcs-gedit rabbitvcs-cli

    sudo apt-get -y install rabbitvcs-nautilus

}

Uninstall_rabbitbvcs() {
    sudo apt-get remove rabbitvcs-nautilus
}
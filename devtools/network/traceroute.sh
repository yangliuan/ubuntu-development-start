#!/bin/bash
Install_Traceroute() {
    apt-get -y install traceroute
}

Uninstall_Traceroute() {
    apt-get -y autoremove traceroute
}
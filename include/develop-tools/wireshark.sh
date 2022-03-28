#!/bin/bash
Install_Wireshark(){
    sudo add-apt-repository ppa:wireshark-dev/stable
    apt update && apt install 
    sudo apt install wireshark
}
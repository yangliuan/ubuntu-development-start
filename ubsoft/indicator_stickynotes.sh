#!/bin/bash
Install_IndicatorStickynotes() {
    apt-add-repository -y ppa:umang/indicator-stickynotes
    apt-get update
    apt-get install -y indicator-stickynotes
}

Uninstall_IndicatorStickynotes() {
    apt-get -y autoremove indicator-stickynotes
    apt-add-repository -r -y ppa:umang/indicator-stickynotes
}
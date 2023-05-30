#!/bin/bash
#Github:https://github.com/atareao/my-weather-indicator
Install_MyWeatherIndicator() {
    add-apt-repository -y ppa:atareao/atareao
    apt-get update
    apt-get -y install my-weather-indicator
}

Uninstall_MyWeatherIndicator() {
    apt-get autoremove my-weather-indicator
    add-apt-repository -y -r ppa:atareao/atareao
    apt-get update
}
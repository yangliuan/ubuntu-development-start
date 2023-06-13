#!/bin/bash
Install_LibplaceboDev() {
    add-apt-repository -y ppa:heyarje/mesa
    apt-get update
    apt-get install -y libplacebo-dev
}

Install_LibplaceboDev() {
    apt-get remove -y libplacebo-dev
    add-apt-repository -r -y ppa:heyarje/mesa
}


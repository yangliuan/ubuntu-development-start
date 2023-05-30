#!/bin/bash
Switch_PHP() {
    #读取目录下名字为php*的目录，存为数组
    php_dir=(`find /usr/local -maxdepth 1 -type d -name "php*" | sort`)
    echo
    echo 'Please select a version of the PHP:'
    #遍历数组打印目录和对应序号
    for i in ${!php_dir[@]};do echo
        echo $i ${php_dir[i]}
    done

    #读取输入序号
    echo
    read -e -p "Please input a number :" php_option
    if [[ ! ${php_option} =~ ^[0-6]$|^6$ ]]; then
        echo "input error! Please only input number 0~6:"
    fi

    #更改PHP版本软连接 输出php相关信息
    echo
    systemctl stop php-fpm.service
    rm -rf /usr/local/php
    ln -s ${php_dir[${php_option}]} /usr/local/php
    echo
    /usr/local/php/bin/php -v
    echo
    echo 'switch php success!'
}
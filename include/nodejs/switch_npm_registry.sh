#!/bin/bash
Switch_NpmRegistry() {
    echo 1;
    #镜像数组
    npm_registry[0]="https://registry.npm.taobao.org"
    npm_registry[1]="http://www.npmjs.org"
    for i in ${!npm_registry[@]};do echo
        echo $i ${npm_registry[i]}
    done

    #获取输入的镜像序号
    echo
    read -e -p "Please input a number :" registry_option
    if [[ ! ${registry_option} =~ ^[0-9]$|^6$ ]]; then
        echo "input error! Please only input number 0~${i}:"
    fi

    npm config set registry ${npm_registry[${registry_option}]}
}
#!/bin/bash
#切换php模块 switch php extenstion
Switch_Extension() {
    
    #目录不存在
    if [ ! -d "/usr/local/php/etc/php.d/disable" ]; then
        mkdir /usr/local/php/etc/php.d/disable
    fi

    #读取目录下名字为php*的目录，存为数组
    enable_dir=(`find /usr/local/php/etc/php.d -maxdepth 1 -type f -name "*.ini" | sort`)
    disable_dir=(`find /usr/local/php/etc/php.d/disable -maxdepth 1 -type f -name "*.ini" | sort`)
    extension_dir=(${enable_dir[@]} ${disable_dir[@]})
    echo

    #遍历数组打印目录和对应序号
    for i in ${!extension_dir[@]};do echo
        echo $i ${extension_dir[i]}
    done

    #读取输入序号
    echo
    read -e -p "Please input a number to enable or disable php extension:(input example '0 1 2')" extension_option
    array_extension_option=(${extension_option})

    for v in ${array_extension_option[@]}; do
        if [[ ! "${v}" =~ ^[0-9]$|^10$ ]]; then
            echo "input error! Please only input number 0~10:"
        fi
        action="disable"
        target_str=${extension_dir[${v}]}
        extension_name=${target_str##/*/}
        if [[ $target_str =~ $action ]]; then
            #启用模块
            mv ${target_str} /usr/local/php/etc/php.d/
            echo "${extension_name} enable success"
        else
            #禁用模块
            mv ${target_str} /usr/local/php/etc/php.d/disable/
            echo "${extension_name} disable success"
        fi
    done
}
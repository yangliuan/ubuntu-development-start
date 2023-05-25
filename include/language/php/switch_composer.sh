#!/bin/bash
#切换composer版本
#https://getcomposer.org/download/
Switch_Composer(){
    #读取所有版本composer文件
    composer_dir=(`find /opt/oneinstack/src/composer -maxdepth 1 -type f -name "composer*" | sort`)
    echo
    echo 'Please select a version of the composer:'
    #遍历输出序号和文件路径
    for i in ${!composer_dir[@]};do echo
        echo $i ${composer_dir[i]}
    done

    #获取输入序号
    echo
    read -e -p "Please input a number :" composer_option
    if [[ ! ${composer_option} =~ ^[0-9]$|^6$ ]]; then
        echo "input error! Please only input number 0~${i}:"
    fi

    #复制指定版本的composer到bin目录
    cp ${composer_dir[${composer_option}]} /usr/local/bin/composer
    chown yangliuan.root /usr/local/bin/composer
    chmod u+x /usr/local/bin/composer

    #输出php和composer版本信息
    /usr/local/php/bin/php -v
    echo
    sudo -u ${run_user} /usr/local/php/bin/php /usr/local/bin/composer -V
    echo 'switch composer success!'
}

#切换composer全局镜像
Switch_Composer_Mirrors(){
    #定义镜像数组
    composer_mirrors[0]="https://mirrors.aliyun.com/composer/"
    composer_mirrors[1]="https://mirrors.cloud.tencent.com/composer/"
    composer_mirrors[2]="https://mirrors.huaweicloud.com/repository/php/"
    composer_mirrors[3]="https://packagist.phpcomposer.com"
    composer_mirrors[4]="https://packagist.org"
    for i in ${!composer_mirrors[@]};do echo
        echo $i ${composer_mirrors[i]}
    done

    #获取输入的镜像序号
    echo
    read -e -p "Please input a number :" mirrors_option
    if [[ ! ${mirrors_option} =~ ^[0-9]$|^6$ ]]; then
        echo "input error! Please only input number 0~${i}:"
    fi

    #更改全局镜像
    sudo -u ${run_user} /usr/local/php/bin/php /usr/local/bin/composer config -g repo.packagist composer ${composer_mirrors[${mirrors_option}]}
    sudo -u ${run_user} /usr/local/php/bin/php /usr/local/bin/composer config -g -l
}

#!/bin/bash
clear
printf "
####################################################################
                choose php framework create project       
####################################################################
"
# Check if user is root
[ $(id -u) = "0" ] && { echo "${CFAILURE}Error: You must not be root to run this script${CEND}"; exit 1; }
oneinstack_dir=$(dirname "`readlink -f $0`")
pushd ${oneinstack_dir} > /dev/null
. ./include/color.sh
. ./include/get_char.sh

#是否创建php框架项目
while :; do echo
    read -e -p "Do you want to create php project? [y/n]: " php_project
    if [[ ! ${php_project} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ ${php_project} == 'y' ]; then
            while :; do echo
                echo 'Please select php framework:'
                echo -e "\t${CMSG}1${CEND}. laravel"
                echo -e "\t${CMSG}2${CEND}. webman"
                echo -e "\t${CMSG}3${CEND}. hyperf"
                echo -e "\t${CMSG}4${CEND}. thinkphp"
                echo -e "\t${CMSG}5${CEND}. yii"
                read -e -p "Please input a number:(Default 1 press Enter) " php_framework
                nginx_option=${php_framework:-1}
                if [[ ! ${php_framework} =~ ^[1-5]$ ]]; then
                    echo "${CWARNING}input error! Please only input number 1~5${CEND}"
                else
                    
                    break
                fi
            done
        fi
        break
    fi
done


if [ ${php_framework} ]; then
    while :; do echo
        read -e -p "请输入框架创建目录： " framework_dir
        if [ -n "${framework_dir}" -a -z "$(echo ${framework_dir} | grep '^/')" ]; then
            echo "输入的目录不合法！"     
        elif [ ! -d "${framework_dir}" ]; then
            echo "目录不存在";
        else
            echo "你的框架安装目录：${framework_dir}"
            break
        fi
    done
    case "${php_framework}" in
    1)
        . include/language/php/framework-init/laravel.sh
        Install_Laravel
        ;;
    2)
        . include/language/php/framework-init/webman.sh
        Install_Webman
        ;;
    3)
        . include/language/php/framework-init/hyperf.sh
        Install_Hyperf
        ;;
    4)
        . include/language/php/framework-init/thinkphp.sh
        Install_Thinkphp
        ;;
    5)
        . include/language/php/framework-init/yii.sh
        Install_Yii
        ;;
    esac
fi

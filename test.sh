#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                            develop test      
####################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

oneinstack_dir=$(dirname "`readlink -f $0`")
pushd ${oneinstack_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/check_os.sh
. ./include/check_dir.sh
. ./include/download.sh
. ./include/get_char.sh
. ./include/base_desktop.sh

# [ -z "`grep ^'export GOROOT=' /etc/profile`" ] && { [ -z "`grep ^'export PATH=' /etc/profile`" ] && echo  "export GOROOT=${go_install_dir}" >> /etc/profile || sed -i "s@^export PATH=@export GOROOT=${go_install_dir}\nexport PATH=@" /etc/profile; } || sed -i "s@^export GOROOT=.*@export GOROOT=${JDK_PATH}@" /etc/profile

# sed -i "s@export PATH@export GOROOT="${go_install_dir}" #GOROOT 设置 ##Go\nexport GOPATH=$WORKSPACE/golang #GOPATH 设置 ##Go\nexport GO111MODULE=\"on\" #开启 Go moudles 特性 ##Go\nexport GOPROXY=https://goproxy.cn,direct #安装Go模块时，代理服务器设置 ##Go\nexport GOPRIVATE=  #指定不走代理的go包域名 ##Go\nexport GOSUMDB=off #关闭校验Go依赖包的哈希值 ##Go\nexport PATH@" /etc/profile

[ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep '$GOROOT/bin' /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=\$GOROOT/bin:\1@" /etc/profile
[ -z "`grep ^'export PATH=' /etc/profile | grep '$GOROOT/bin'`" ] && echo 'export PATH=$GOROOT/bin:$PATH' >> /etc/profile
[ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep '$GOPATH/bin' /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=\$GOPATH/bin:\1@" /etc/profile
[ -z "`grep ^'export PATH=' /etc/profile | grep '$GOPATH/bin'`" ] && echo 'export PATH=$GOPATH/bin:$PATH' >> /etc/profile
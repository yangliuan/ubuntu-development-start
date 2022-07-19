#!/bin/bash
#REF:https://time.geekbang.org/column/article/378076
Install_Go() {
    pushd ${oneinstack_dir}/src > /dev/null
    src_url=http://mirror.yangliuan.cn/go${go_ver}.linux-amd64.tar.gz && Download_src
    tar -xvzf go${go_ver}.linux-amd64.tar.gz
    mv -rfv go ${go_install_dir}${go_ver}
    
    if [ -L /usr/local/go ]; then
        rm -rf /usr/local/go
    fi

    if [ ! -d "${go_path}" ]; then
        mkdir ${go_path}
    fi

    ln -s ${go_install_dir}${go_ver} ${go_install_dir}
    sed -i "s@export PATH@export GOROOT="${go_install_dir}" #GOROOT 设置 ##Go\nexport GOPATH=${go_path} #GOPATH 设置 ##Go\nexport GO111MODULE=\"on\" #开启 Go moudles 特性 ##Go\nexport GOPROXY=https://goproxy.cn,direct #安装Go模块时，代理服务器设置 ##Go\nexport GOPRIVATE=  #指定不走代理的go包域名 ##Go\nexport GOSUMDB=off #关闭校验Go依赖包的哈希值 ##Go\nexport PATH@" /etc/profile

    [ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep '$GOROOT/bin' /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=\$GOROOT/bin:\1@" /etc/profile
    [ -z "`grep ^'export PATH=' /etc/profile | grep '$GOROOT/bin'`" ] && echo 'export PATH=$GOROOT/bin:$PATH' >> /etc/profile
    [ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep '$GOPATH/bin' /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=\$GOPATH/bin:\1@" /etc/profile
    [ -z "`grep ^'export PATH=' /etc/profile | grep '$GOPATH/bin'`" ] && echo 'export PATH=$GOPATH/bin:$PATH' >> /etc/profile
    
    echo "install Go successed!"
}

Uninstall_Go() {
    sed -i '/##Go$/d' /home/${run_user}/.bashrc
    source /home/${run_user}/.bashrc
    rm -rf /home/${run_user}/go/

    echo "uninstall Go successed!"
}
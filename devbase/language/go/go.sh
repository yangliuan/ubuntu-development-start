#!/bin/bash
#REF:https://time.geekbang.org/column/article/378076
Install_Go() {
    pushd ${ubdevenv_dir}/src/devbase/golang > /dev/null
    src_url=https://golang.google.cn/dl/go${go_ver}.linux-amd64.tar.gz && Download_src
    tar -xvzf go${go_ver}.linux-amd64.tar.gz
    mv -fv go ${go_install_dir}${go_ver}
    
    if [ -L /usr/local/go ]; then
        rm -rf /usr/local/go
    fi

    if [ ! -d "${go_path}" ]; then
        mkdir ${go_path}
        chown -R ${run_user}:${run_group} ${go_path}
    fi

    ln -s ${go_install_dir}${go_ver} ${go_install_dir}

    if [ ! -e "/etc/profile.d/go.sh" ]; then
        cat >> /etc/profile.d/go.sh <<EOF
##Go env
export GOROOT=${go_install_dir} #GOROOT 设置 ##Go
export GOPATH=${go_path} #GOPATH 设置 ##Go
export GO111MODULE="auto" #开启 Go moudles 特性 ##Go
export GOPROXY=https://goproxy.cn,direct #安装Go模块时，代理服务器设置 ##Go
export GOPRIVATE=  #指定不走代理的go包域名 ##Go
export GOSUMDB=off #关闭校验Go依赖包的哈希值 ##Go
export PATH=\$GOROOT/bin:\$GOPATH/bin:\$PATH
EOF
        . /etc/profile.d/go.sh
        . /etc/profile
    fi

    echo "install Go successed!"
}

Uninstall_Go() {
    echo "Uninstall Go"
    rm -rf /etc/profile.d/go.sh
    rm -rfv ${go_install_dir}
    rm -rfv ${go_install_dir}${go120_ver}
    rm -rfv ${go_install_dir}${go119_ver}
    rm -rfv ${go_install_dir}${go118_ver}
    rm -rfv ${go_install_dir}${go117_ver}
    rm -rfv ${go_path}
    echo "uninstall Go successed!"
}
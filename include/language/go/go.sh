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

    ln -s ${go_install_dir}${go_ver} /usr/local/go

    tee -a /home/${run_user}/.bashrc <<'EOF'
# Go envs
export GOROOT=$GO_INSTALL_DIR/$GOVERSION #GOROOT 设置 ##Go
export GOPATH=$WORKSPACE/golang #GOPATH 设置 ##Go
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH #将Go语言自带的和通过 go install 安装的二进制文件加入到 PATH 路径中 ##Go
export GO111MODULE="on" #开启 Go moudles 特性 ##Go
export GOPROXY=https://goproxy.cn,direct #安装Go模块时，代理服务器设置 ##Go
export GOPRIVATE=  #指定不走代理的go包域名 ##Go
export GOSUMDB=off #关闭校验Go依赖包的哈希值 ##Go
EOF
   source /home/${run_user}/.bashrc
#    go version
#    mkdir -p $GOPATH && cd $GOPATH
#    go work init
#    go env GOWORK #执行此命令，查看 go.work 工作区文件路径
   echo "install Go successed!"
}

Uninstall_Go() {
    sed -i '/##Go$/d' /home/${run_user}/.bashrc
    source /home/${run_user}/.bashrc
    rm -rf /home/${run_user}/go/
    echo "uninstall Go successed!";
}
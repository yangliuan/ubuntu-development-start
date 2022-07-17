#!/bin/bash
#REF:https://time.geekbang.org/column/article/378076
Install_Go() {
    echo 'install go'
    pushd ${oneinstack_dir}/src > /dev/null
    src_url=http://mirror.yangliuan.cn/dl/go${go_ver}.linux-amd64.tar.gz && Download_src
    
    if [ ! -d "$HOME/go" ];then
        mkdir -p $HOME/go
    fi

    mv $HOME/go/go $HOME/go/go${go_ver}
    tee -a $HOME/.bashrc <<'EOF'
# Go envs
export GOVERSION=go"${go_ver}" #Go 版本设置
export GO_INSTALL_DIR=$HOME/go #Go 安装目录
export GOROOT=$GO_INSTALL_DIR/$GOVERSION #GOROOT 设置
export GOPATH=$WORKSPACE/golang #GOPATH 设置
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH #将Go语言自带的和通过 go install 安装的二进制文件加入到 PATH 路径中
export GO111MODULE="on" #开启 Go moudles 特性
export GOPROXY=https://goproxy.cn,direct #安装Go模块时，代理服务器设置
export GOPRIVATE=  #指定不走代理的go包域名
export GOSUMDB=off #关闭校验Go依赖包的哈希值
EOF
   go version
   mkdir -p $GOPATH && cd $GOPATH
   go work init
   go env GOWORK #执行此命令，查看 go.work 工作区文件路径
}

Uninstall_Go() {
    echo 'uninstall go'
}
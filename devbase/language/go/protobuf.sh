#!/bin/bash
#REF:https://time.geekbang.org/column/article/378076
Install_ProtoBuf() {
    pushd ${ubdevenv_dir}/src > /dev/null
    #安装 protobuf
    git clone -b v3.21.1 --depth=1 https://github.com/protocolbuffers/protobuf
    pushd protobuf > /dev/null
    ./autogen.sh
    ./configure
    make -j ${THREAD} && make install
    protoc --version
    rm -rf protobuf
    popd > /dev/null
    popd > /dev/null
    #安装 protoc-gen-go
    go install github.com/golang/protobuf/protoc-gen-go@v1.5.2
}
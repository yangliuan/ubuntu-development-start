#!/bin/bash
#REF:https://www.erlang.org/doc/installation_guide/install#how-to-build-and-install-erlang-otp
Install_Erlang() {
   pushd ${oneinstack_dir}/src > /dev/null
   echo "Download erlang ..."
   src_url="https://github.com/erlang/otp/releases/download/OTP-${erlang_ver}/otp_src_${erlang_ver}.tar.gz" && Download_src
   tar -zxf otp_src_${erlang_ver}.tar.gz
   cd otp_src_${erlang_ver}.tar.gz
   ./configure
   make -j ${THREAD} && make install
   erl -version
}

Uninstall_Erlang() {
    rm -rf /usr/local/erlang
}
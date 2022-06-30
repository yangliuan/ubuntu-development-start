#!/bin/bash
Install_Erlang() {
   pushd ${oneinstack_dir}/src > /dev/null
   echo "Download erlang ..."
   src_url="https://github.com/erlang/otp/releases/download/OTP-${erlang_ver}/otp_src_${erlang_ver}.tar.gz" && Download_src
   
}

Uninstall_Erlang() {
    
}
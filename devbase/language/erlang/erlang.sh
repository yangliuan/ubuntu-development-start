#!/bin/bash
#REF:https://www.erlang.org/doc/installation_guide/install#how-to-build-and-install-erlang-otp
Install_Erlang() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download erlang ..."
    src_url="https://github.com/erlang/otp/releases/download/OTP-${erlang_ver}/otp_src_${erlang_ver}.tar.gz" && Download_src
    tar -zxf otp_src_${erlang_ver}.tar.gz
    pushd otp_src_${erlang_ver}  > /dev/null
    #不指定安装目录前缀，原因使用自定义用户rabbitmq运行rabbitmq-server时找不到erl
    #./configure --prefix=${erlang_install_dir}
    ./configure
    make -j ${THREAD} && make install
    popd > /dev/null
#全局环境变量没有生效,用自定义用户rabbitmq运行rabbitmq-server时找不到erl，正常用户可以
#     if [ ! -e "/etc/profile.d/erlang.sh" ]; then
#         cat > /etc/profile.d/erlang.sh << EOF
# export ERL_HOME=${erlang_install_dir}
# export PATH=\$ERL_HOME/bin:\$PATH
# EOF
#         . /etc/profile
#     fi

    rm -rf otp_src_${erlang_ver}
    echo "erlang install success!";
    popd > /dev/null
}

Uninstall_Erlang() {
    #rm -rfv ${erlang_install_dir} /etc/profile.d/erlang.sh
    rm -rf /usr/local/lib/erlang
    pushd /usr/local/bin > /dev/null
    rm -rfv ct_run dialyzer epmd erl erlc escript run_erl to_erl typer
    popd > /dev/null
}
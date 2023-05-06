#!/bin/bash
#REF:https://www.erlang.org/doc/installation_guide/install#how-to-build-and-install-erlang-otp
Install_Erlang() {
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download erlang ..."
    src_url="https://github.com/erlang/otp/releases/download/OTP-${erlang_ver}/otp_src_${erlang_ver}.tar.gz" && Download_src
    tar -zxf otp_src_${erlang_ver}.tar.gz
    cd otp_src_${erlang_ver}
    ./configure --prefix=${erlang_install_dir}
    make -j ${THREAD} && make install

    if [ ! -e "/etc/profile.d/erlang.sh" ]; then
        cat > /etc/profile.d/erlang.sh << EOF
export ERL_HOME=${erlang_install_dir}
export PATH=\$ERL_HOME/bin:\$PATH
EOF
        . /etc/profile.d/erlang.sh
        . /etc/profile
    fi

    rm -rfv otp_src_${erlang_ver}
    echo "erlang install success!";
    popd > /dev/null
}

Uninstall_Erlang() {
    rm -rfv ${erlang_install_dir} /etc/profile.d/erlang.sh
}
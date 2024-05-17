#!/bin/bash
#DOC https://rocketmq.apache.org/zh/docs/quickStart/01quickstart
#https://www.jianshu.com/p/3733903440d1
#https://blog.51cto.com/u_14900374/2576431
Install_RocketMQ(){
    pushd ${ubdevenv_dir}/src/devbase/database > /dev/null
    src_url="https://dist.apache.org/repos/dist/release/rocketmq/${rocketmq_ver}/rocketmq-all-${rocketmq_ver}-bin-release.zip" && Download_src
    unzip rocketmq-all-${rocketmq_ver}-bin-release.zip
    mv -fv rocketmq-all-${rocketmq_ver}-bin-release ${rocketmq_install_dir}
    cp -rfv ${ubdevenv_dir}/init.d/rocketmq-broker.service ${ubdevenv_dir}/init.d/rocketmq-namesrv.service /lib/systemd/system/
    sed -i "s@/usr/local/rocketmq@${rocketmq_install_dir}@g" /lib/systemd/system/rocketmq-namesrv.service
    sed -i "s@/usr/local/rocketmq@${rocketmq_install_dir}@g" /lib/systemd/system/rocketmq-broker.service
    systemctl daemon-reload
    popd > /dev/null
}

Uninstall_RocketMQ(){
    rm -rfv ${rocketmq_install_dir} /lib/systemd/system/rocketmq-broker.service /lib/systemd/system/rocketmq-namesrv.service
}
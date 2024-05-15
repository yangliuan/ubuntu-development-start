#!/bin/bash
#微信原生linux测试版
#https://blog.csdn.net/hool_wei/article/details/138730203
Install_Wechat() {
    pushd ${ubdevenv_dir}/src/ubsoft
        if CheckInstall_DebFiles libssl1.1_1.1.1w-0+deb11u1_amd64.deb electronic-wechat-icons-atzlinux_1.0.5_all.deb com.tencent.wechat_1.0.0.241_amd64.deb; then
            echo "wechat bete installed!"
        else
            echo "建议在虚拟机中使用铜豌豆软件源手动下载微信DEB包，代码地址：${ubdevenv_dir}/src/ubsoft/wechat.sh Download_WechatDeb"
        fi
    popd > /dev/null
}

Uninstall_Wechat() {
    apt-get autoremove com.tencent.wechat electronic-wechat-icons-atzlinux libssl1.1
}

###download wechat
##建议在虚拟机中操作如下步骤获取wechatbete安装包
##软件来源铜豌豆Linuxhttps://www.atzlinux.com
Download_WechatDeb() {
    wget -c https://www.atzlinux.com/atzlinux/pool/main/a/atzlinux-archive-keyring/atzlinux-v12-archive-keyring_lastest_all.deb
    sudo dpkg -i atzlinux-v12-archive-keyring_lastest_all.deb
    sudo apt-get update
    sudo apt-get install -y atzlinux-store-v12
    sudo apt-get download electronic-wechat-icons-atzlinux com.tencent.wechat libssl1.1
}

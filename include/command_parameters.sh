#!/bin/bash
version() {
  echo "version: 2.0"
  echo "updated date: 2023-06-01"
}

Show_Ubsoft_Help() {
  version
  echo "Usage: $0  command ...[parameters]....
  --help, -h                  Show this help message
  --version, -v               Show version info
  --all                       all software
  --input_method_option[1-3]  input method googlepin sogoupin baidupin       
  --baidunetdisk              baidu network disk
  --deepinwine                deepin software wechat qq...
  --dingtalk_flag             dingtalk
  --linuxqq                   tencent qq for linux IM tool
  --feishu                    byte dance office tool
  --flameshot                 screentshot
  --indicator_sysmonitor      taskbar system monitoring
  --indicator_stickynotes     note tool
  --lantern                   science online
  --neteasy_cloudmusic        music platform
  --qqmusic                   music platform
  --peek                      screenshot for video
  --qv2ray                    science online
  --sougoupinyin              sougou input
  --sunlogin                  remote control tool
  --theme_tools               ubuntu theme tools
  --vlc                       video player
  --wps                       office tool
  --xDroid                    run android app
  --conky                     desktop monitoring tool
  "
}
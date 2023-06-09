#!/bin/bash
# ufw
if [ "${firewall_flag}" == 'y' ]; then
  if ! dpkg -s openssh-server >/dev/null 2>&1 ; then
      . ./devbase/ftp/openssh-server.sh && Install_OpensshServer
  fi

  ufw allow 22/tcp
  [ "${ssh_port}" != "22" ] && ufw allow ${ssh_port}/tcp
  ufw allow 80/tcp
  ufw allow 443/tcp
  ufw --force enable
else
  ufw --force disable
fi

systemctl restart rsyslog

# 判断如果存在ssh服务并且ssh已启动则重启
if ps aux | grep sshd | grep -v grep >/dev/null && systemctl is-active --quiet ssh; then
  systemctl restart ssh
  echo "SSH 已成功重启。"
else
  echo "SSH 服务未运行或者已被停止。无法重启。"
fi

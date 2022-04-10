#!/bin/bash
[ -z "`grep ^'export PATH=' /etc/profile`" ] && echo "export PATH=${php_env_dir}/bin:\$PATH" >> /etc/profile
[ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep ${php_env_dir} /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=${php_env_dir}/bin:\1@" /etc/profile
#切换成当前安装版本
rm -rf /usr/local/php
ln -s ${php_dir[${php_option}]} /usr/local/php

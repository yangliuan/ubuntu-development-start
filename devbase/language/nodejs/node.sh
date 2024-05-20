#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_Node() {
  pushd ${ubdevenv_dir}/src/devbase/nodejs > /dev/null
  # nodejs
  echo "Download Nodejs..."
  [ "${OUTIP_STATE}"x == "China"x ] && DOWN_ADDR_NODE=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release || DOWN_ADDR_NODE=https://nodejs.org/dist
  src_url=${DOWN_ADDR_NODE}/v${nodejs_ver}/node-v${nodejs_ver}-linux-${SYS_ARCH_n}.tar.gz && Download_src
  tar xzf node-v${node_ver}-linux-${SYS_ARCH_n}.tar.gz
  /bin/mv node-v${node_ver}-linux-${SYS_ARCH_n} ${node_install_dir}
  if [ -e "${node_install_dir}/bin/node" ]; then
    cat > /etc/profile.d/node.sh << EOF
export NODE_HOME=${node_install_dir}
export PATH=\$NODE_HOME/bin:\$PATH
EOF
    . /etc/profile
    echo "${CSUCCESS}Nodejs installed successfully! ${CEND}"
  else
    echo "${CFAILURE}Nodejs install failed, Please contact the author! ${CEND}" && lsb_release -a
    kill -9 $$; exit 1;
  fi
  popd > /dev/null
}

Uninstall_Node() {
  if [ -e "${node_install_dir}" ]; then
    rm -rf ${node_install_dir} /etc/profile.d/node.sh
    echo "${CMSG}Node uninstall completed! ${CEND}"
  fi
}


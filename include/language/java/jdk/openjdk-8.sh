#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_OpenJDK8() {
  apt --no-install-recommends -y install openjdk-8-jdk
  JAVA_HOME=/usr/lib/jvm/java-8-openjdk-${SYS_ARCH}
  
  if [ -e "${JAVA_HOME}/bin/java" ]; then
    cat > /etc/profile.d/openjdk.sh << EOF
export JAVA_HOME=${JAVA_HOME}
export CLASSPATH=\$JAVA_HOME/lib/tools.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib
EOF
    . /etc/profile.d/openjdk.sh
    echo "${CSUCCESS}OpenJDK8 installed successfully! ${CEND}"
  else
    echo "${CFAILURE}OpenJDK8 install failed, Please contact the author! ${CEND}" && lsb_release -a
    kill -9 $$; exit 1;
  fi
}

Uninstall_OpenJDK8() {
  apt autoremove openjdk-8-jdk
  rm -rfv /etc/profile.d/openjdk.sh /etc/java-8-openjdk
}
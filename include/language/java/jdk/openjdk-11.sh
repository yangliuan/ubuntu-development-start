#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_OpenJDK11() {
  apt --no-install-recommends -y install openjdk-11-jdk
  JAVA_HOME=/usr/lib/jvm/java-11-openjdk-${SYS_ARCH}
  
  if [ -e "${JAVA_HOME}/bin/java" ]; then
    cat > /etc/profile.d/openjdk.sh << EOF
export JAVA_HOME=${JAVA_HOME}
export CLASSPATH=\$JAVA_HOME/lib/tools.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib
EOF
    . /etc/profile.d/openjdk.sh
    echo "${CSUCCESS}OpenJDK11 installed successfully! ${CEND}"
  else
    echo "${CFAILURE}OpenJDK11 install failed, Please contact the author! ${CEND}" && lsb_release -a
    kill -9 $$; exit 1;
  fi
}

Uninstall_OpenJDK11() {
  apt autoremove openjdk-11-jdk
  rm -rfv /etc/profile.d/openjdk.sh /etc/java-11-openjdk
}
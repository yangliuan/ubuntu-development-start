#!/bin/bash
Install_Iptables() {
    apt-get -y install debconf-utils
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    apt-get -y install iptables-persistent

    if [ -e "/etc/iptables/rules.v4" ] && [ -n "$(grep '^:INPUT DROP' /etc/iptables/rules.v4)" -a -n "$(grep 'NEW -m tcp --dport 22 -j ACCEPT' /etc/iptables/rules.v4)" -a -n "$(grep 'NEW -m tcp --dport 80 -j ACCEPT' /etc/iptables/rules.v4)" ]; then
        IPTABLES_STATUS=yes
    else
        IPTABLES_STATUS=no
    fi

    if [ "${IPTABLES_STATUS}" == "no" ]; then
        cat > /etc/iptables/rules.v4 << EOF
# Firewall configuration written by system-config-securitylevel
# Manual customization of this file is not recommended.
*filter
:INPUT DROP [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:syn-flood - [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
-A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
COMMIT
EOF
    fi

    FW_PORT_FLAG=$(grep -ow "dport ${ssh_port}" /etc/iptables/rules.v4)
    [ -z "${FW_PORT_FLAG}" -a "${ssh_port}" != "22" ] && sed -i "s@dport 22 -j ACCEPT@&\n-A INPUT -p tcp -m state --state NEW -m tcp --dport ${ssh_port} -j ACCEPT@" /etc/iptables/rules.v4
    iptables-restore < /etc/iptables/rules.v4
    /bin/cp /etc/iptables/rules.v{4,6}
    sed -i 's@icmp@icmpv6@g' /etc/iptables/rules.v6
    ip6tables-restore < /etc/iptables/rules.v6
    ip6tables-save > /etc/iptables/rules.v6 
}

Uninstall_Iptables() {
    
}
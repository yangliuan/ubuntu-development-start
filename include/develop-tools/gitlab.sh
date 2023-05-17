#DOC https://about.gitlab.com/install/#ubuntu
#!/bin/bash
Install_Gitlab() {
    sudo apt-get update
    sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
    sudo apt-get install -y postfix
    curl -fsSL https://packages.gitlab.cn/repository/raw/scripts/setup.sh | bash
    sudo EXTERNAL_URL="http://gitlab.local" apt-get install gitlab-jh
}

Uninstall_Gitlab() {
    sudo apt remove gitlab-jh postfix tzdata
    sudo rm -rf /etc/apt/sources.list.d/gitlab-jh.list
}
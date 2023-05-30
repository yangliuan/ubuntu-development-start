#/bin/bash
Install_Docker_Repository() {
    #Add Docker’s official GPG key 
    [ ! -d "/etc/apt/keyrings" ] &&  install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg
    #Use the following command to set up the repository:
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
    #update
    sudo apt-get update
}

Uninstall_Docker_Repository() {
    rm -rf /etc/apt/keyrings/docker.gpg
    rm -rf /etc/apt/sources.list.d/docker.list
    sudo apt-get update
}

Install_Docker_Engine() {
    apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    systemctl disable docker.service
    [ -d "/opt/containerd" ] && chown -R ${run_user}.${run_group} /opt/containerd
}

Uninstall_Docker_Engine() {
    systemctl stop docker.service
    apt-get -y purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    rm -rf /var/lib/docker /var/lib/containerd
}

Install_Docker_Desktop() {
   pushd ${ubdevenv_dir}/src > /dev/null
   echo "Download docker-desktop ..."
   src_url="https://desktop.docker.com/linux/main/amd64/docker-desktop-${docker_desktop_ver}-amd64.deb" && Download_src
   dpkg -i docker-desktop-${docker_desktop_ver}-amd64.deb
   apt-get -y install -f
   [ -d "/opt/docker-desktop" ] && chown -R ${run_user}.${run_group} /opt/docker-desktop
   popd > /dev/null
}

Uninstall_Docker_Desktop() {
    dpkg -P docker-desktop
    apt-get -y autoremove
}
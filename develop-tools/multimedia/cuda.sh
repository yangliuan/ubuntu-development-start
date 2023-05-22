#/bin/bash
Install_Cuda() {
    pushd ${oneinstack_dir}/src > /dev/null
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb
    dpkg -i cuda-keyring_1.0-1_all.deb
    apt-get update
    apt-get -y install cuda
    popd > /dev/null
}

Uninstall_Cuda() {
    apt-get -y autoremove cuda
    dpkg -P cuda-keyring cuda-toolkit-12-1-config-common cuda-toolkit-12-config-common cuda-toolkit-config-common cuda-visual-tools-12-1
}
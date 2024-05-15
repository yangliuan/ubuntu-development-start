#!/bin/bash
#https://www.nvidia.cn/Download/index.aspx?lang=cn Official Download Page
Install_NvidiaDriver() {
    apt-get -y install nvidia-driver-${nvidia_driver_ver} nvidia-utils-${nvidia_driver_ver} nvidia-settings 
}

#https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64 Download Page
Install_Cuda() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/${SYS_ARCH_nv}/cuda-keyring_${cuda_ver}_all.deb
    dpkg -i cuda-keyring_${cuda_ver}_all.deb
    apt-get update
    apt-get -y install cuda
    [ -d "/opt/nvidia" ] && chown -R ${run_user}:${run_group} /opt/nvidia
    popd > /dev/null
}

Uninstall_Cuda() {
    apt-get -y autoremove cuda
    dpkg -P cuda-keyring cuda-toolkit-12-1-config-common cuda-toolkit-12-config-common cuda-toolkit-config-common cuda-visual-tools-12-1
    [ -d "/opt/nvidia" ] && rm -rf /opt/nvidia
}

Install_AMDDriver() {
    echo
}

Install_Driver() {
    if lspci | grep -i NVIDIA > /dev/null; then
        Install_NvidiaDriver
        Install_Cuda
    fi

    if lspci -nn | grep VGA | grep AMD > /dev/null; then
        Install_AMDDriver
    fi
}

Uninstall_Driver() {
    Uninstall_Cuda
}
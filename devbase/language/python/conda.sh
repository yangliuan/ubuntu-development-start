#!/bin/bash
#https://www.anaconda.com/download-success download page
#https://developer.aliyun.com/mirror/anaconda/ download page
#https://docs.conda.io/en/latest/ doc page
#https://github.com/conda/conda repo page

Install_Conda() {
    pushd ${ubdevenv_dir}/src > /dev/null
    src_url=http://mirrors.aliyun.com/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh && Download_src
    bash Miniconda3-latest-Linux-x86_64.sh -b -p ${conda_install_dir}
    
    if [ -e "${conda_install_dir}/bin/conda" ]; then
        echo "${CSUCCESS}conda installed successfully! ${CEND}"
    else
        echo "${CFAILURE}conda install failed, Please contact the author! ${CEND}" && lsb_release -a
        kill -9 $$; exit 1;
    fi

#     if [ ! -e "/etc/profile.d/conda.sh" ]; then
#         cat > /etc/profile.d/conda.sh << EOF
# export PATH=${conda_install_dir}/bin:\$PATH
# EOF
#         . /etc/profile
#     fi

    #switch mirror to aliyun
    if [ ! -e "/home/${run_user}/.condarc" ]; then
        cat > /home/${run_user}/.condarc << EOF
channels:
  - defaults
show_channel_urls: true
default_channels:
  - http://mirrors.aliyun.com/anaconda/pkgs/main
  - http://mirrors.aliyun.com/anaconda/pkgs/r
  - http://mirrors.aliyun.com/anaconda/pkgs/msys2
custom_channels:
  conda-forge: http://mirrors.aliyun.com/anaconda/cloud
  msys2: http://mirrors.aliyun.com/anaconda/cloud
  bioconda: http://mirrors.aliyun.com/anaconda/cloud
  menpo: http://mirrors.aliyun.com/anaconda/cloud
  pytorch: http://mirrors.aliyun.com/anaconda/cloud
  simpleitk: http://mirrors.aliyun.com/anaconda/cloud
  nvidia: https://mirrors.aliyun.com/anaconda/cloud
EOF
      chown -R ${run_user}.${run_group} /home/${run_user}/.condarc
    fi

    ${conda_install_dir}/bin/conda init
    ${conda_install_dir}/bin/conda clean -i -y
    popd > /dev/null
}

Uninstall_Conda() {
    [ -e "${conda_install_dir}/bin/conda" ] && conda deactivate
    rm -rfv ${conda_install_dir} /etc/profile.d/conda.sh /home/${run_user}/.condarc /home/${run_user}/.conda
    sed -i '/# >>> conda initialize >>>/,/# <<< conda initialize <<</d' /home/${run_user}/.bashrc
}
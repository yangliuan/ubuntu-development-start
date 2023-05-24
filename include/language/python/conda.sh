#!/bin/bash
Install_Conda() {
    pushd ${oneinstack_dir}/src > /dev/null
    src_url=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && Download_src
    bash Miniconda3-latest-Linux-x86_64.sh -b -p ${conda_install_dir}

    if [ -e "${conda_install_dir}/bin/conda" ]; then
        echo "${CSUCCESS}conda installed successfully! ${CEND}"
    else
        echo "${CFAILURE}conda install failed, Please contact the author! ${CEND}" && lsb_release -a
        kill -9 $$; exit 1;
    fi

    if [ ! -e "/etc/profile.d/conda.sh" ]; then
        cat > /etc/profile.d/conda.sh << EOF
export PATH=${conda_install_dir}/bin:\$PATH
EOF
        . /etc/profile
    fi

    popd > /dev/null
}

Uninstall_Conda() {
    conda deactivate
    rm -rfv ${conda_install_dir} /etc/profile.d/conda.sh
}


#!/bin/bash
Install_Hyperf() {
    pushd $framework_dir
    composer create-project hyperf/hyperf-skeleton 
}
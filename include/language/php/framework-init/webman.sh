#!/bin/bash
Install_Webman() {
    pushd $framework_dir
    composer create-project workerman/webman
}
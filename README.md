# ubuntu20.04+ 开发环境安装脚本

集成Oneinstack Nvm 等常用开发工具脚本，快速搭建开发环境

### 使用方法

复制配置文件，修改配置项和版本，具体参考oneinstack
cd /opt

git clone git@github.com:yangliuan/ubuntu-development-start.git oneinstack

修改 options.conf versions.txt 配置文件，将run_user和run_group改成自己的用户

首先运行 sudo ./install_base.sh 安装开发环境

运行 sudo ./install_devtools.sh 安装开发工具

运行 sudo ./switch_env.sh 切换环境，可以切换php版本，php扩展，composer版本，composer镜像，nginx发行版


### Thinks

[Oneinstack](https://github.com/oneinstack/oneinstack)

[Nvm](https://github.com/nvm-sh/nvm)


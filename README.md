# ubuntu20.04+ 开发环境安装脚本

集成Oneinstack Nvm 等常用开发工具脚本，快速搭建开发环境

### 使用方法

复制配置文件，修改配置项和版本，具体参考oneinstack,nvm的使用方式

```shell
cd /opt

git clone git@github.com:yangliuan/ubuntu-development-start.git oneinstack

修改 options.conf versions.txt 配置文件，将run_user和run_group改成自己的用户

首先运行 sudo ./install_base.sh 安装开发环境

运行 sudo ./install_devtools.sh 安装开发工具

运行 sudo ./switch_env.sh 切换环境，可以切换php版本，php扩展，composer版本，composer镜像，nginx发行版
```

### 简单示例
```shell
#切换php扩展

sudo /opt/oneinstack/switch_env.sh --php_extension

#######################################################################
                      Switch Develop Environment
#######################################################################

0 /usr/local/php/etc/php.d/event.ini

1 /usr/local/php/etc/php.d/fileinfo.ini

2 /usr/local/php/etc/php.d/imagick.ini

3 /usr/local/php/etc/php.d/redis.ini

4 /usr/local/php/etc/php.d/swoole.ini

5 /usr/local/php/etc/php.d/disable/opcache.ini

6 /usr/local/php/etc/php.d/disable/pgsql.ini

7 /usr/local/php/etc/php.d/disable/xdebug.ini

8 /usr/local/php/etc/php.d/disable/yasd.ini

Please input a number to enable or disable php extension:(input example '0 1 2')0 4
event.ini disable success
swoole.ini disable success

```

### Thinks

[Oneinstack](https://github.com/oneinstack/oneinstack)

[Nvm](https://github.com/nvm-sh/nvm)


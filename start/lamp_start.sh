#!/bin/sh
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:

systemctl start nginx.service
systemctl start php-fpm.service
systemctl start mysqld.service
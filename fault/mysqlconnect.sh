#!/bin/bash
#// 进入容器
#docker exec -it php-container-name /bin/bash
#// 切换目录
#cd /usr/local/bin 
#// 安装pdo_mysql扩展
#./docker-php-ext-install pdo_mysql  
#//  安装mysqli扩展
#./docker-php-ext-install mysqli
#// 退出容器
#exit
#// 重启容器
#docker restart php-container-name
docker exec -it php-container-name /bin/bash -c 'cd /usr/local/bin && ./docker-php-ext-install pdo_mysql && ./docker-php-ext-install mysqli'

#!/bin/bash
#配置yum源
a=`pwd`
cp $a/CentOS7.repo /etc/yum.repos.d/CentOS7.repo
stat1=$?
cp $a/docker-ce.repo /etc/yum.repos.d/docker-ce.repo
stat2=$?
mkdir ~/.pip
cp $a/pip.conf ~/.pip/pip.conf
stat3=$?
let stat=$stat1+$stat2+$stat3
if ((stat==0)); then
yum clean all && yum makecache
yum install -y yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum remove -y docker docker-io docker-selinux python-docer-py;
yum install -y docker-ce
systemctl enable docker
cp $a/daemon.json /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker
docker pull mysql:5.7
echo "MySQL name:mysql1"
echo "MySQL password:mysql1"
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysql1 --name mysql1 mysql:5.7
docker pull php:7.2-fpm
echo "PHP name: phpfpm1"
docker run -d -v /var/nginx/www/html:/var/www/html -p 9000:9000 --link mysql1:mysql --name phpfpm1 php:7.2-fpm >>php.txt
docker pull nginx:1.12.2
echo "nginx name: nginx1"
docker run -d -p 80:80 --name nginx1 -v /var/nginx/www/html:/var/www/html --link phpfpm1:phpfpm --name nginx1 nginx:1.12.2 >>2.txt
nginxname=`cat $a/2.txt`
phpname=`cat $a/php.txt`
sed -i "s/7a7012317cc1/$phpname/" $a/default.conf
docker cp $a/default.conf  $dockername:/etc/nginx/conf.d/default.conf
docker exec -it $dockername /bin/bash -c 'nginx -t' 
docker exec -it $dockername /bin/bash -c 'nginx -s reload' 
yum install -y unzip
unzip Discuz_X3.4_GIT_SC_UTF8.zip -d /var/nginx/www/html/
mv /var/nginx/www/html/config/config_global_default.php /var/nginx/www/html/config/config_global.php
mv /var/nginx/www/html/config/config_ucenter_default.php /var/nginx/www/html/config/config_ucenter.php
chmod -Rf 777 /var/nginx/www/html/config/
chmod -Rf 777 /var/nginx/www/html/data/
chmod -Rf 777 /var/nginx/www/html/uc_client/
chmod -Rf 777 /var/nginx/www/html/uc_server/

echo "浏览器访问ip地址"

else
echo "缺少文件";
fi

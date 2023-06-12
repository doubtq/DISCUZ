#!/bin/bash
#配置yum源
currentfilepath=`pwd`
cp $currentfilepath/CentOS7.repo /etc/yum.repos.d/CentOS7.repo
stat1=$?
cp $currentfilepath/docker-ce.repo /etc/yum.repos.d/docker-ce.repo
stat2=$?
mkdir ~/.pip
cp $currentfilepath/pip.conf ~/.pip/pip.conf
stat3=$?
let stat=$stat1+$stat2+$stat3
if ((stat==0)); then
/bin/bash $currentfilepath/yum.sh
systemctl enable docker
cp $currentfilepath/daemon.json /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker
docker pull mysql:5.7
echo "MySQL name:mysql1"
echo "MySQL password:mysql1"
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysql1 --name mysql1 mysql:5.7
docker pull php:7.2-fpm
echo "PHP name: phpfpm1"
docker run -d -v /var/nginx/www/html:/var/www/html -p 9000:9000 --link mysql1:mysql --name phpfpm1 php:7.2-fpm >php.txt
docker pull nginx:1.12.2
echo "nginx name: nginx1"
docker run -d -p 80:80 --name nginx1 -v /var/nginx/www/html:/var/www/html --link phpfpm1:phpfpm --name nginx1 nginx:1.12.2 >2.txt
nginxname=`cat $currentfilepath/2.txt`
phpname=`cat $currentfilepath/php.txt`
sed -i "s/7a7012317cc1/$phpname/" $a/default.conf
docker cp $currentfilepath/default.conf  $dockername:/etc/nginx/conf.d/default.conf
docker exec -it $dockername /bin/bash -c 'nginx -t' 
docker exec -it $dockername /bin/bash -c 'nginx -s reload' 
yum install -y unzip
unzip Discuz_X3.4_GIT_SC_UTF8.zip -d /var/nginx/www/html/
bash $currentfilepath/move.sh
#修改权限
/bin/bash $currentfilepath/htmlpermission.sh

echo "浏览器访问ip地址"

else
echo "缺少文件";
fi

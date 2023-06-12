#!/bin/bash

yum clean all && yum makecache
yum install -y yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum remove -y docker docker-io docker-selinux python-docer-py;
yum install -y docker-ce

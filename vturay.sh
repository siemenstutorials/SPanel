#!/bin/bash

#install base
rpm -q curl || yum install -y curl
rpm -q wget || yum install -y wget
apt-get install git -y || yum install git -y

#check docker
docker version > /dev/null || curl -fsSL get.docker.com | bash
service docker restart
systemctl start docker
systemctl enable docker
systemctl stop firewalld
systemctl disable firewalld

#config
read -p "Please Input Node_ID：" id

#docker_run
docker run -d --name=b${id} \
-v /root/.cert:/root/.cert \
-e API=https://v2rayssrgo.xyz \
-e TOKEN=fab93f2c75962143c3 \
-e NODE=${id} \
-e LICENSE=d094808e1c1f70aa72a966e2226a55da \
-e SYNCINTERVAL=60 \
--restart=always \
--network=host \
tokumeikoi/aurora
docker ps -a
echo -e "\033[32m 安装完成 \033[0m"

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

#config
read -p "Please Input Node_ID：" id
read -p "Please Input Lisense：" token

#docker_run
docker run -d --name=T${id} \
-v /root/.cert:/root/.cert \
-e API=https://v2rayssrgo.xyz \
-e TOKEN=v2rayssrgo \
-e NODE=${id} \
-e LICENSE=${token} \
-e SYNCINTERVAL=60 \
--restart=always \
--network=host \
tokumeikoi/aurora
docker ps -a
echo -e "\033[32m Finsh Installed \033[0m"

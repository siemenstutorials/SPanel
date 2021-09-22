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
read -p "Please input NodeID(Default NodeID:1)：" nodeid
read -p "Please input Offsetted Port(Offsetted Port:10089)：" port_1
muKey=Lyb4534195
host=https://www.xn--9kq078cs77a.com
port_2=10086

#docker
docker run -d --name=s${nodeid} -e NODE_ID=${nodeid} -e API_INTERFACE=modwebapi -e WEBAPI_URL=${host}  -e SPEEDTEST=0 -e WEBAPI_TOKEN=${muKey} --log-opt max-size=50m --log-opt max-file=3 -p ${port_1}:${port_2}/tcp -p ${port_1}:${port_2}/udp  --restart=always docker pull v2raysrgo/newssrmu
docker ps -a
echo -e "\033[32m Docker安装完成 \033[0m"

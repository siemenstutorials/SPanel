#!/bin/bash
##############################################################
#                                                            #
# Author：Changed By Siemenstutorials                        #
#                                                            #
# Youtube channel:https://www.youtube.com/c/siemenstutorials #
#                                                            # 
# XRAY-OneKey v1.0                                           #
#                                                            #
##############################################################
rpm -q curl || yum install -y curl
rpm -q wget || yum install -y wget
apt-get install git -y || yum install git -y
#docker_check
docker version > /dev/null || curl -fsSL get.docker.com | bash
service docker restart
systemctl start docker
systemctl enable docker

#config_file
SN=`cat /proc/sys/kernel/random/uuid`
git clone https://github.com/siemenstutorials/xraygo /tmp/$SN && cd /tmp/$SN
sleep 5s
file="./config.yml"
link="http://127.0.0.1:667"
docker_compose_file="./docker-compose.yml"

#install docker-compose
curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
cp -rf /usr/local/bin/docker-compose /usr/bin/docker-compose
clear

#Input info

#read -p "请输入面板地址：" apihost
#read -p "请输入前端面板KEY："  apikey
apikey=Lyb4534195
apihost=https://www.xn--9kq078cs77a.com
read -p "请输入节点ID：" nodeid
#read -p "请输入容器名：" docker_name
docker_name=v$nodeid
#config_setting
sed -i "s|$link|${apihost}|" $file
sed -i "s|123|${apikey}|" $file
sed -i "s|41|$nodeid|" $file
sed -i "s|HIM|${docker_name}|" $docker_compose_file

echo "Configuration complete"
echo "正在启动XrayR Docker Compose" && docker-compose up -d


 
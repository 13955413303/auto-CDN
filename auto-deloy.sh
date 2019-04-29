#!/bin/bash
echo -n "E3/E5/VCA2 --> "
read cpu
if [[ 'E3/E5/VCA2' =~ $cpu ]]
then
        echo $cpu
else
        echo 'error input'
        exit 1
fi


# rm build && cfg
rm -rf ./build
rm -rf /etc/systemd/system/docker.service.d/proxy.conf

# set proxy
declare -x http_proxy="http://child-prc.intel.com:913"
declare -x https_proxy="http://child-prc.intel.com:913"

apt-get install -y docker.io

apt-get install -y ffmpeg

apt-get install -y ansible
touch /etc/systemd/system/docker.service.d/proxy.conf
printf '[Service]\nEnvironment="HTTPS_PROXY=http://child-prc.intel.com:913" "NO_PROXY=hub.docker.intel.com,localhost"\n' | sudo tee /etc/systemd/system/docker.service.d/proxy.conf 

systemctl daemon-reload
systemctl restart docker

funcE3_VCA2(){
#path=$(pwd)
mkdir ${path}/build
cd ${path}/build/ && cmake ..

chmod +777 ${path}/xcode-server/ffmpeg-hw/build.sh
cd ${path}/build/xcode-server/ffmpeg-hw && make

chmod +777 ${path}/cdn-server/build.sh
cd ${path}/build/cdn-server && make

chmod +777 ${path}/deployment/docker-swarm/build.sh
chmod +777 ${path}/deployment/docker-swarm/start.sh
chmod +777 ${path}/deployment/docker-swarm/stop.sh
chmod +777 ${path}/deployment/docker-swarm/self-sign.sh
cd ${path}/build/deployment/docker-swarm && make
}

funcE5(){
#path=$(pwd)
mkdir ${path}/build
cd ${path}/build/ && cmake ..

chmod +777 ${path}/xcode-server/ffmpeg-sw/build.sh
cd ${path}/build/xcode-server/ffmpeg-sw && make

chmod +777 ${path}/cdn-server/build.sh
cd ${path}/build/cdn-server && make

chmod +777 ${path}/deployment/docker-swarm/build.sh
chmod +777 ${path}/deployment/docker-swarm/start.sh
chmod +777 ${path}/deployment/docker-swarm/stop.sh
chmod +777 ${path}/deployment/docker-swarm/self-sign.sh
cd ${path}/build/deployment/docker-swarm && make

}
path=$(pwd)
if [ 'E3' == $cpu ]
then
        funcE3_VCA2
fi

if [ 'VCA2' == $cpu ]
then
        funcE3_VCA2
fi

if [ 'E5' == $cpu ]
then
        funcE5
fi



# get pwd
sed -i "s?locate?${path}?" ${path}/auto-web.yml




#ansible-playbook ${path}/autoweb.yml

cd ${path}/build/ && make stop_docker_compose
cd ${path}/build/ && make start_docker_compose













# install ansible
#apt-get install ansible

# get pwd
#path_=$(pwd)
#sed -i "s?/path?${path_}?" ./docker-repo/docker-ansible-cfg.yml

#ansible-playbook ./docker-repo/docker-ansible-cfg.yml

# clear pwd
#_path=$(pwd)
#sed -i "s?${_path}?/path?" ./docker-repo/docker-ansible-cfg.yml




#ansible-playbook ./docker-ansible-cfg.yml



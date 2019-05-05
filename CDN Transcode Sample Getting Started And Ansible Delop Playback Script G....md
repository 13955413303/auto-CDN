## CDN Transcode Sample Getting Started And Ansible Delop Playback Script Guide


**This document describes two important functions.
1.Auto build the CDN Transcode Sample and complete make start_docker_compose on server.
2.Realize the deployment of automatic playback script by Ansible and auto playback on client.**
&nbsp;


### step 1:
+ #### Download the CDN-Transcode-Sample package
###### Run below command on server:
```
git clone https://github.com/OpenVisualCloud/CDN-Transcode-Sample
```

+ #### Auto deployment the CDN-Transcode-Sample
###### Run below command on server:
```
cd CDN-Transcode-Sample/auto-CDN/ && ./auto-deloy.sh
```
&nbsp;



### step 2:
 *Open another terminal *
+ #### Generate ssh key on the server, which we have to copy to all the remote hosts(client machine) for doing deployments or configurations on them:
###### Run below command on server:
```
cd /root/
ssh-keygen -t rsa
```

+ #### copy the ssh key generated to the remote hosts (Before copying the ssh key make sure that you are able to ssh the remote host where you want to copy the key):
###### Run below command on server:
```
ssh-copy-id -i .ssh/id_rsa.pub username@client_machine_ip
```

+ #### Add IP address,the username and password  of the target machines one by one, so that automatic playback script package will successfully copied to these target machines:
###### Run below command on server:
```
vim /etc/ansible/hosts
client_machine_ip ansible_ssh_user=username ansible_ssh_pass='password' ansible_become_pass='password'
```
&nbsp;


### step 3:
+ #### Realize the deployment of automatic playback script by Ansible
###### Run below command on server:
```
cd CDN-Transcode-Sample/auto-CDN/ && ansible-playbook auto-web.yml
```

+ #### Make all users have access to GUI programs to control remote host browser(Root is necessary, but media is not.)
###### Run below command on Client Local Termina
```
xhost +
```

+ #### run the playback script and  google browser will auto play. 
###### Run below command on client:
```
cd /home/media/test/ && ./export.sh
```

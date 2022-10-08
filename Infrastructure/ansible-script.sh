#!/bin/bash
sleep 10
sudo sed -i 's/1/0/1' /etc/yum/pluginconf.d/subscription-manager.conf
sudo yum update -y
sudo yum -y install python3-pip git ansible nano
cd /home/ec2-user 
git clone https://github.com/turancyberhub/ansible_DevOps2022.git
sudo chown -R ec2-user:ec2-user ansible_DevOps2022/
chmod 400 ./ansible_DevOps2022/ssh-key.pem


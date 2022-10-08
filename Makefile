create_infra:
terraform apply -target module.infrastructure --auto-approve

destroy infra:
terraform destory -target module.infrastructure --auto-approve

create_repo:
terraform apply -target module.github_repo --auto-approve

destory_repo:
terraform destory -target module.github_repo --auto-approve

create:
  terraform init ; \
  terraform fmt --diff --check --recursive ; \
  terraform apply --auto-approve

destory:
  terraform destory --auto-approve

  Notes:
  
# terraform apply -target module.infrastructure
# terraform destory -target module.infrastructure

# terraform apply -target module.github_repo
# terraform destory -target module.github_repo

# terraform init
# terraform fmt --diff --check --recursive
# terraform apply --auto-approve

# vi /etc/yum/pluginconf.d/subscription-manager.conf

# inventory file 
#   k8s ansible_host=172.16.0.70
#   jenkins ansible_host=172.16.0.178

#   [all:vars]
#   ansible_ssh_private_key_file=/home/ec2-user/ssh-key.pem

# due to redhat account subscription issues you may need to run ansible-script components by your own.

# edit inventory file and put your ec2 instances private ips corresponding line
# ansible-playbook install-k8s.yml -i inventory
# ansible-playbook install-jenkins.yml -i inventory

# add publish over ssh & maven integrator
# publish over ssh make sure pasting private key & adding ansible instance as ssh server
# use https://github.com/tbincan/final-project-resources-DevOps2022 as remote repository & branch master
# building secrets USERNAME & PASSWORD /Credentials-Add docker hub username & password
# make sure correctly locate pom file java-maven-app/pom.xml & clean install
# post steps: cd java-maven-app/
#   docker build -t tbincan/final_project:1.0 .
#   echo $PASSWORD | docker login -u $USERNAME --password-stdin
#   docker push tbincan/final_project:1.0
#
# Send files or execute commands over SSH: ansible ip/dnsname ; cd /home/ec2-user/ansible_DevOps2022; ansible-playbook install-java-app.yml -i inventory

# export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
# echo $JAVA_HOME
# yum install java-11-openjdk-devel -y
# sudo chmod 0666 /var/run/docker.sock
# ansible-playbook -i /home/ec2-user/ansible_DevOps2022/inventory /home/ec2-user/ansible_DevOps2022/install-java-app.yml
# cd /home/ec2-user/ansible_DevOps2022; ansible-playbook -i inventory install-java-app.yml
# cd ~/ansible_DevOps2022; ansible-playbook -i inventory install-java-app.yml
# kubectl port-forward service/java-app 8080:8080 --address 0.0.0.0
# kubectl taint nodes --all node-role.kubernetes.io/control-plane-

  # - name: Jenkins Initial Password
  #   command:
  #     shell: cat /var/lib/jenkins/secrets/initialAdminPassword
  #     register: result
 
  # - name: Print init password Jenkins
  #   debug:
  #     var: result.stdout
  # http://<hostname>/descriptorByName/hudson.tools.JDKInstaller/enterCredential
# TuranCyberHub Final Project

## Description
The infrastructure is to be provisioned on AWS using Terraform IAC, Confiuration Management is to be done by using Ansible, and taking code from repository building as an artifact and running web applicaiton in containarized form on Kubernetes Server (CI/CD) is to be done by using Jenkins. 
For more information, watch the video:
https://youtu.be/uQPuPyaeMkI
Some visuals:
https://excalidraw.com/#json=xEENL8m_37G4_U3GeS3ih,fDCq3VEb08hpRvY5Whyzeg

## Requirements
| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.29 |

## Providers
| Name | Version |
|------|---------|
| <a name="hashicorp/aws"></a> [aws](#provider\_aws) | >= 3.29 |
| <a name="integrations/github"></a> [github](#provider\_github) | >= 5.0 |

## Usage

You can reach the module using the GitHub URL: https://github.com/T1kcan/ansible_DevOps2022

Put your own variables into variables.tf file. You may leave as the default ones. 
To install this module you may need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
$ terraform apply -target module.infrastructure
$ terraform destory -target module.infrastructure

$ terraform apply -target module.github_repo
$ terraform destory -target module.github_repo

$ terraform init
$ terraform fmt --diff --check --recursive
$ terraform apply --auto-approve
```
## Github Repository

A public Github Repository is to be cretaed. Thence you need to modify values on main.tf `github-emmail` ,`github-username` and `github-token` in /Repository Module's local variables and put your own values.

## Ansible Server

Don't forget to change Redhat Subscription Manager settings:
```bash
vi /etc/yum/pluginconf.d/subscription-manager.conf
```
Edit inventory file and put your ec2 instances private ips corresponding lineCreate inventory file:
```bash
vi inventory
```
```yml 
[hosts]
k8s ansible_host=172.16.0.70
jenkins ansible_host=172.16.0.178

[all:vars]
ansible_ssh_private_key_file=/home/ec2-user/ssh-key.pem
```

Finally, run the ansible commands one by one
```bash
ansible-playbook install-jenkins.yml -i inventory
ansible-playbook install-k8s.yml -i inventory
```
Note: Installation might take sometime, please wait till the end.
Put your docker hub image name into deployment.yml
Prepare install-jenkins.yml manifest file that creates Jenkins Server

## Jenkins Server Settings
Add publish over ssh & maven integrator
Configure publish over ssh make sure pasting private key & adding ansible instance as ssh server
Should you happen to reset Oracle User Account use following pattern: http://<hostname>/descriptorByName/hudson.tools.JDKInstaller/enterCredential
In case of docker run error make sure that docker socket is enabled: sudo chmod 0666 /var/run/docker.sock
Create Maven Job
Use https://github.com/tbincan/final-project-resources-DevOps2022 as remote repository & branch master
Build secrets DOCKER_USERNAME & DOCKER_PASSWORD /Credentials-Add docker hub username & password
Make sure correctly locate pom file java-maven-app/pom.xml & clean install
Post steps: 
   cd java-maven-app/
   docker build -t tbincan/final_project:1.0 .
   echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
   docker push tbincan/final_project:1.0
Send files or execute commands over SSH: 
```text
ansible ip/dnsname ; cd /home/ec2-user/ansible_DevOps2022; ansible-playbook install-java-app.yml -i inventory
```
## Kubernetes Server
Make sure that Control Plane is set to run pods: kubectl taint nodes --all node-role.kubernetes.io/control-plane-
Publish web application through port forward: 
```bash
kubectl port-forward service/java-app 8080:8080 --address 0.0.0.0
```

## Parameters for Configuration
| Variable Name | Description | Type | Default Value
|---------------|-------------|------|---------------|
| region | AWS Region | string | "us-east-1" |
| aws_access_key | Which key will be used | string | "ssh_key.pem" |
| private_key_path | Where is your key located | string | "/c/Utils/TuranCyberHub/final-project-resources-DevOps2022/Infrastructure" |
| vpc_cidr | CIDR Block of VPC | string | "172.16.0.0/16" |
| subnet1_cidr  | Subnet 01 CIDR Block | string | "172.16.0.0/24" |
| instance_type | Ansible and (Jenkins & Kubernetes Servers EC2 type) | list(string) | ["type-1", "type-2"] |
| ec2_type-1 | Ansible Server Type | string | "t2.micro" |
| ec2_type-2 | Kubernetes & Jenkins Server Type | string | "t3a.medium" |
| num_of_instance | How many instances will be created | number | 2 |
| keyy_name | AWS Key Name | string | "ssh-key" |
| pub_key_location | Public Key File Path&file | string | "c:/Utils/TuranCyberHub/final-project-resources-DevOps2022/Infrastructure/ssh-key.pub" |
| user_data_location | User Data File Path&file | string | "c:/Utils/TuranCyberHub/final-project-resources-DevOps2022/Infrastructure/ansible-script.sh" |
| type1-tag | Key/Value pairs to assign to the default tags | string | "Ansible Instance" |
| type2-tag | Key/Value pairs to assign to the default tags | list(string) | ["Jenkins", "Kubernetes"] |

## Outputs
| Output Name | Description | Type |
|---------------|-------------|------|
| Ansible_instance_dns | Ansible Instance DNS address | string |
| Ansible_instance_pub_ip | Ansible Instance Public IP address | string |
| Jenkins_instance_dns | Jenkins Instance DNS address | string |
| Jenkins_instance_dns | Jenkins Instance Public IP address | string |
| Kubernetes_instance_dns | Ansible Instance DNS address | string |
| Kubernetes_instance_dns | Kubernetes Instance DNS address | string |
| Github_Repository_SVN | Github Repository SVN | string |
| Github_Repository_URL | Github Repository URL | string |

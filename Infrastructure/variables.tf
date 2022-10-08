variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "Which key will be used"
  type        = string
  default     = "ssh_key.pem"
}

variable "private_key_path" {
  description = "Where is your key located"
  type        = string
  default     = "/c/Utils/TuranCyberHub/final-project-resources-DevOps2022/Infrastructure"
}

variable "vpc_cidr" {
  description = "CIDR Block of VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "subnet1_cidr" {
  description = "Subnet 01 CIDR Block"
  type        = string
  default     = "172.16.0.0/24"
}

variable "instance_type" {
  description = "Ansible and (Jenkins & Kubernetes Servers EC2 type)"
  type        = list(string)
  default     = ["type-1", "type-2"]
}

variable "ec2_type-1" {
  description = "Ansible Server Type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_type-2" {
  description = "Kubernetes & Jenkins Server Type"
  type        = string
  default     = "t3a.medium"
}

variable "num_of_instance" {
  description = "How many instances will be created"
  type        = number
  default     = 2
}

variable "keyy_name" {
  description = "AWS Key Name"
  type        = string
  default     = "ssh-key"
}

variable "pub_key_location" {
  description = "Public Key File Path&file"
  type        = string
  default     = "c:/Utils/TuranCyberHub/final-project-resources-DevOps2022/Infrastructure/ssh-key.pub"
}

variable "user_data_location" {
  description = "User Data File Path&file"
  type        = string
  default     = "c:/Utils/TuranCyberHub/final-project-resources-DevOps2022/Infrastructure/ansible-script.sh"
}

# variable "tf-tags" {
#   type    = list(string)
#   default = ["First", "Second"]
# }

variable "type1-tag" {
  type    = string
  default = "Ansible Instance"
}

variable "type2-tag" {
  type    = list(string)
  default = ["Jenkins", "Kubernetes"]
}
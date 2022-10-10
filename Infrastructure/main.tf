# VPC
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
}
# SUBNET
resource "aws_subnet" "subnet1" {
  cidr_block              = var.subnet1_cidr
  vpc_id                  = aws_vpc.vpc1.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
  depends_on              = [aws_internet_gateway.IGW]
}

# INTERNET_GATEWAY
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc1.id
}

# ROUTE_TABLE
resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}

resource "aws_route_table_association" "route-subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route1.id
}

# SECURITY_GROUP
resource "aws_security_group" "sg-tf" {
  name        = "final-project-sg"
  description = "terraform security group for final project"
  tags = {
    "Name" = "Tf-Sg-FP"
  }
  vpc_id = aws_vpc.vpc1.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ELASTIC IP
resource "aws_eip" "EIP" {
  instance = aws_instance.type-1.id
  vpc      = true
}

resource "aws_eip" "eip_manager" {
  instance = element(aws_instance.type-2.*.id, count.index)
  count    = var.num_of_instance
  vpc      = true

  tags = {
    Name = "eip-${var.ec2_type-2}-${count.index + 1}"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file(var.pub_key_location)
}

# ANSIBLE INSTANCE 
resource "aws_instance" "type-1" {
  ami                    = data.aws_ami.aws-redhat.id
  instance_type          = var.ec2_type-1
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.sg-tf.id]
  key_name               = var.keyy_name
  user_data              = file(var.user_data_location)
  tags = {
    "Name" = "Terraform ${var.type1-tag} Instance"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("c:/Utils/TuranCyberHub/final-project-resources-DevOps2022/Infrastructure/ssh-key.pem")
  }

  provisioner "file" {
    source      = "ansible_DevOps2022"
    destination = "ansible_DevOps2022"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 ./ansible_DevOps2022/ssh-key.pem",
      #"clear",
    ]
    on_failure = continue
  }

  provisioner "local-exec" {
    command = "echo http://${self.public_ip} >> public_ip.txt"
  }
  provisioner "local-exec" {
    command = "echo http://${self.private_ip} > private_ip.txt"
  }
}

# INSTANCE II
resource "aws_instance" "type-2" {
  ami                    = data.aws_ami.aws-redhat.id
  instance_type          = var.ec2_type-2
  count                  = var.num_of_instance
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.sg-tf.id]
  key_name               = var.keyy_name
  tags = {
    "Name" = "Terraform ${element(var.type2-tag, count.index)} Instance"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("c:/Utils/TuranCyberHub/final-project-resources-DevOps2022/Infrastructure/ssh-key.pem")
  }

  provisioner "file" {
    content     = self.public_ip
    destination = "/home/ec2-user/my_public_ip.txt"
    on_failure  = continue
  }
}

# //////////////////////////////
# DATA
# //////////////////////////////
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "aws-redhat" {
  most_recent = true
  owners      = ["309956199498"] # Redhat Account ID

  filter {
    name   = "name"
    values = ["RHEL-8.6.0_HVM*"] #RHEL-8*
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "instance_type" {}
variable "instance_name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "security_group_name" {}

# configure aws provider
provider "aws" {
  region = "us-east-1"
  #profile = "Admin"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# create instance
resource "aws_instance" "web_server01" {
  ami = "ami-08c40ec9ead489470"
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  security_groups = [aws_security_group.web_ssh.id]
  #key_name = ""

  #user_data = "${file("deploy.sh")}"

  tags = {
    "Name" : var.instance_name
  }

}

# create security groups

resource "aws_security_group" "web_ssh" {
  name        = var.security_group_name
  description = "open ssh traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "tf_made_sg"
    "Terraform" : "true"
  }

}

output "instance_ip" {
  value = aws_instance.web_server01.public_ip
}

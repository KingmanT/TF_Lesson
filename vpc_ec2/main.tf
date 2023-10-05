# Configure aws provider
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
  #profile = "Admin"
}

# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block              = "172.19.0.0/16"
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "tf-made-vpc"
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id #will cause error
  cidr_block              = "172.19.0.0/16"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "tf-made-subnet"
  }
}

# Create Security Groups

resource "aws_security_group" "web_ssh" {
  name        = "tf_made_sg"
  description = "open ssh traffic"
  vpc_id = aws_vpc.vpc.id


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

# Create instance
resource "aws_instance" "web_server01" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.web_ssh.id]
  #key_name = "ubuntuSandbox"

  #user_data = "${file("deploy.sh")}"

  tags = {
    "Name" : "tf_made_instance"
  }

}


output "instance_ip" {
  value = aws_instance.web_server01.public_ip
}

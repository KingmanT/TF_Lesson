# configure aws provider
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
  #profile = "Admin"
}

# create instance
resource "aws_instance" "web_server01" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  key_name = "ubuntuSandbox"

  user_data = "${file("deploy.sh")}"

  tags = {
    "Name" : "tf_made_instance"
  }

}

# create security groups

resource "aws_security_group" "web_ssh" {
  name        = "ssh-access"
  description = "open ssh traffic"


  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 8080
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

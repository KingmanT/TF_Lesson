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

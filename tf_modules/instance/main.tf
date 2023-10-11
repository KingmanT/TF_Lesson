# Create Security Groups

resource "aws_security_group" "web_ssh" {
  name        = "${var.project_name}_sg"
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

# Create instance
resource "aws_instance" "web_server01" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  security_groups = [aws_security_group.web_ssh.id]
  key_name = var.key_name

  #user_data = "${file("deploy.sh")}"

  tags = {
    "Name" : "${var.project_name}_instance"
  }

}

resource "aws_vpc" "vpc" {
  cidr_block              = "172.19.0.0/16"
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "172.19.0.0/16"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "${var.project_name}-subnet"
  }
}

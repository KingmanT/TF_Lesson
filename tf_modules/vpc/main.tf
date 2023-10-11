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

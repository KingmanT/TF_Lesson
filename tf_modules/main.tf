variable "aws_access_key" {}
variable "aws_secret_key" {}

# configure aws provider
provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Create VPC
module "vpc" {
  source = "./vpc"
  region = var.region
  project_name = var.project_name
}

# Create Instance
module "instance" {
  source = "./instance"
  project_name = var.project_name
  ami = var.ami
  instance_type = var.instance_type
  key_name            = var.key_name
  subnet_id           = module.vpc.subnet_id
  vpc_id              = module.vpc.vpc_id

}

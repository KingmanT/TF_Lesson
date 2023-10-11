output "region" {
    value = var.region
}

output "project_name" {
    value = var.project_name
}

output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet_id" {
    value = aws_subnet.my_subnet.id
}

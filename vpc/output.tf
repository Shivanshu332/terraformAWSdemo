output "vpc_id" {
    value = aws_vpc.shiv_vpc.id
}

output "public_subnet_id" {
    value = aws_subnet.shiv_public_subnet.id
}

output "private_subnet_id" {
    value = aws_subnet.shiv_private_subnet.id
}
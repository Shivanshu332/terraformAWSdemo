resource "aws_vpc" "shiv_vpc" {
    cidr_block = "12.0.0.0/16"
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "shiv_public_subnet" {
    vpc_id = aws_vpc.shiv_vpc.id
    cidr_block = "12.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = var.public_subnet_name
    }
}

resource "aws_subnet" "shiv_private_subnet" {
    vpc_id = aws_vpc.shiv_vpc.id
    cidr_block = "12.0.2.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name = var.private_subnet_name
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.shiv_vpc.id

    tags = {
        Name = var.internet_gateway_name
    }
}

resource "aws_route_table" "public_RT" {
    vpc_id = aws_vpc.shiv_vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
        Name = "public_RT"
    }
}

resource "aws_route_table_association" "public_RT_association"{
    subnet_id = aws_subnet.shiv_public_subnet.id
    route_table_id = aws_route_table.public_RT.id
}

# resource "aws_eip" "elastic_ip" {
#     domain = "vpc"
#     instance = aws_instance.web_instance2.id
#     depends_on = [ aws_instance.web_instance2 ]
# }

# resource "aws_nat_gateway" "nat_gateway"{
#     allocation_id = aws_eip.elastic_ip.id
#     subnet_id = aws_subnet.shiv_public_subnet.id
# }

# resource "aws_route_table" "private_RT"{
#     vpc_id = aws_vpc.shiv_vpc.id

#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_nat_gateway.nat_gateway.id
#     }
#     tags = {
#         Name = "privateRT"
#     }
# }

# resource "aws_route_table_association" "private_RT_association" {
#     subnet_id = aws_subnet.shiv_private_subnet.id
#     route_table_id = aws_route_table.private_RT.id
# }
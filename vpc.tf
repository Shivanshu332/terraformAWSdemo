resource "aws_vpc" "shiv_vpc" {
    cidr_block = "12.0.1.0/16"
    tags = {
        Name = "shiv_vpc"
    }
}

resource "aws_subnet" "shiv_public_subnet" {
    vpc_id = aws_vpc.shiv_vpc.id
    cidr_block = "12.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "shiv_public_subnet"
    }
}

resource "aws_subnet" "shiv_private_subnet" {
    vpc_id = aws_vpc.shiv_vpc.id
    cidr_block = "12.0.2.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name = "shiv_private_subnet"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_pc.shiv_vpc.id

    tags = {
        Name = "shiv_internet_gateway"
    }
}

resource "aws_route_table" "public_RT" {
    vpc_id = aws_vpc.shiv_vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
        Name = public_RT
    }
}

resource "aws_route_table_association" "public_RT_association"{
    subnet_id = aws_subnet.shiv_public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "elastic_ip" {
    domain = vpc
}

resource "aws_nat_gateway" "nat_gateway"{
    allocation_id = aws_eip.elastic_ip.id
    subnet_id = aws_subnet.shiv_public_subnet_id
}

resource "aws_route_table" "private_RT"{
    vpc_id = aws_vpc.shiv_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway.id
    }
    tags = {
        Name = "privateRT"
    }
}

resource "aws_route_table_association" "private_RT_association" {
    subnet_id = aws_subnet.shiv_private_subnet.id
    route_table_id = aws_route_table.private_RT
}

resource "aws_security_group" "webSG" {
    name        = "web_security_group"
    
    vpc_id      = aws_vpc.shiv_vpc

    tags = {
        Name = "web_security_group"
    }

    ingress {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    }

    ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       =["0.0.0.0/0"]
    }

    egress {
        from_port     = 0
        to_port       = 0
        protocol      = "-1"
        cidr_blocks   = ["0.0.0.0/0"]
    }
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["amazon/RHEL-9.5.0_HVM-20241211-x86_64-0-Hourly2-GP3*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["309956199498"]
}

resource "aws_instance" "web_instance" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.webSG.id]
    subnet_id = aws_subnet.shiv_public_subnet.id
    user_data = base64encode(file(userdata.sh))

    tags = {
        Name = "web_instance"
    }
}

resource "aws_instance" "web_instance2" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.webSG.id]
    subnet_id = aws_subnet.shiv_private_subnet.id
    user_data = base64encode(file(userdata.sh))

    tags = {
        Name = "web_instance2"
    }
}
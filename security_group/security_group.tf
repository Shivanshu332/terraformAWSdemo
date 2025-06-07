resource "aws_security_group" "web_loadbalancer_SG" {
    name   = var.security_group_name
    vpc_id = var.vpc_id

    tags = {
        Name = var.security_group_name
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_security_group" "web_instance_SG" {
    name   = var.security_group_name
    vpc_id = var.vpc_id

    tags = {
        Name = var.security_group_name
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "http"
        security_groups = [ aws_security_group.web_loadbalancer_SG.id ]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "ssh"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
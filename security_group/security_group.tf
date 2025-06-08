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
    name   = "web_instance_SG"
    vpc_id = var.vpc_id

    tags = {
        Name = "web_instance_SG"
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "allow_http_from_alb" {
    type                     = "ingress"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    security_group_id        = aws_security_group.web_instance_SG.id
    source_security_group_id = aws_security_group.web_loadbalancer_SG.id
}

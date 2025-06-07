data "aws_ami" "rhel" {
    most_recent = true
    filter {
        name   = "name"
        values = [var.ami_name]
    }
    filter {
        name   = "virtualization-type"
        values = [var.virtualization_type]
    }
    owners = ["309956199498"]
}

resource "aws_launch_template" "public_launch_template" {
    name_prefix            = "public_launch_template"
    image_id               = data.aws_ami.rhel.id
    instance_type          = var.instance_type_public
    vpc_security_group_ids = [aws_security_group.webSG.id]
    user_data              = base64encode(file("${path.module}/userdata.sh"))
    network_interfaces {
        subnet_id = module.vpc.public_subnet_id
    }
}

resource "aws_launch_template" "private_launch_template" {
    name_prefix            = "private_launch_template"
    image_id               = data.aws_ami.rhel.id
    instance_type          = var.instance_type_public
    vpc_security_group_ids = [aws_security_group.webSG.id]
    user_data              = base64encode(file("${path.module}/userdata.sh"))
    network_interfaces {
    subnet_id = module.vpc.private_subnet_id
    }
}


resource "aws_autoscaling_group" "asg_public" {
    desired_capacity = var.desired_capacity_public
    max_size         = var.max_size_public
    min_size         = var.min_size_public

    launch_template {
        id      = aws_launch_template.public_launch_template.id
        version = "$Latest"
    }
    }

    resource "aws_autoscaling_group" "asg_private" {
    desired_capacity = var.desired_capacity_private
    max_size         = var.max_size_private
    min_size         = var.min_size_private

    launch_template {
        id      = aws_launch_template.private_launch_template.id
        version = "$Latest"
    }
    }
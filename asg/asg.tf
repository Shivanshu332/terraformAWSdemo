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
    vpc_security_group_ids = [var.security_group_id]
    user_data              = base64encode(file("${path.module}/userdata.sh"))
    network_interfaces {
        subnet_id = var.public_subnet_id
    }
}

resource "aws_launch_template" "private_launch_template" {
    name_prefix            = "private_launch_template"
    image_id               = data.aws_ami.rhel.id
    instance_type          = var.instance_type_public
    vpc_security_group_ids = [var.security_group_id]
    user_data              = base64encode(file("${path.module}/userdata.sh"))
    network_interfaces {
    subnet_id = var.private_subnet_id
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

resource "aws_autoscaling_schedule" "asg_private_morning_scheduler" {
    scheduled_action_name  = "morning_scheduler"
    min_size               = 1
    max_size               = 1
    desired_capacity       = 1
    recurrence             = "0 6 * * *"
    time_zone              = "Asia/Kolkata" 
    autoscaling_group_name = aws_autoscaling_group.asg_private.name
}

resource "aws_autoscaling_schedule" "asg_private_evening_scheduler" {
    scheduled_action_name  = "evening_scheduler"
    min_size               = 0
    max_size               = 0
    desired_capacity       = 0
    recurrence             = "0 18 * * *"
    time_zone              = "Asia/Kolkata" 
    autoscaling_group_name = aws_autoscaling_group.asg_private.name
}
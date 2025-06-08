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

resource "aws_launch_template" "private_launch_template" {
    name_prefix            = "private_launch_template"
    image_id               = data.aws_ami.rhel.id
    instance_type          = var.instance_type_private
    user_data              = base64encode(file("${path.module}/userdata.sh"))
    
    network_interfaces {
        subnet_id = var.private_subnet_id
        security_groups = [ var.instance_security_group_id ]
        
    }
}

resource "aws_autoscaling_group" "asg_private" {
    desired_capacity   = var.desired_capacity_private
    max_size           = var.max_size_private
    min_size           = var.min_size_private
    target_group_arns  = var.target_group_arn
    launch_template {
        id      = aws_launch_template.private_launch_template.id
        version = "$Latest"
    }
}

resource "aws_autoscaling_schedule" "asg_private_morning_scheduler" {
    scheduled_action_name  = "morning_scheduler"
    min_size               = var.morning_min_size
    max_size               = var.morning_max_size
    desired_capacity       = var.morning_min_size
    recurrence             = var.morning_recurrence
    time_zone              = "Asia/Kolkata" 
    autoscaling_group_name = aws_autoscaling_group.asg_private.name
}

resource "aws_autoscaling_schedule" "asg_private_evening_scheduler" {
    scheduled_action_name  = "evening_scheduler"
    min_size               = var.evening_min_size
    max_size               = var.evening_max_size
    desired_capacity       = var.evening_desired_capacity
    recurrence             = var.evening_recurrence
    time_zone              = "Asia/Kolkata" 
    autoscaling_group_name = aws_autoscaling_group.asg_private.name
}
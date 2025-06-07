resource "aws_lb" "web_alb" {
    name               = "web-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [var.lb_security_group_id]
    subnets            = [var.public_subnet_id]
}


resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.web_alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }
}

resource "aws_lb_target_group" "tg" {
    name     = "web-app-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
}
output "loadbalancer_security_group_id" {
    value = aws_security_group.web_loadbalancer_SG.id
}

output "instance_security_group_id" {
    value = aws_security_group.web_instance_SG.id
}
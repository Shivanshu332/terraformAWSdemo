// vpc variables
variable "vpc_name" { type = string }
variable "public_subnet_name" { type = string }
variable "private_subnet_name" { type = string }
variable "internet_gateway_name" { type = string }

// security group variables
variable "security_group_name" { type = string }

//instance variables
variable "ami_name" { type = string }
variable "virtualization_type" { type = string }
variable "instance_type_public" { type = string }
variable "instance_type_private" { type = string }
variable "instance_name_public" { type = string }
variable "instance_name_private" { type = string }
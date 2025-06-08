//asg variables
variable "ami_name"                     { type = string }
variable "virtualization_type"          { type = string }
variable "instance_type_private"        { type = string }
variable "instance_name_private"        { type = string }
variable "desired_capacity_private"     { type = number }
variable "min_size_private"             { type = number }
variable "max_size_private"             { type = number }
variable "private_subnet_id"            {}
variable "instance_security_group_id"   {}

//asg scheduler variables
variable "morning_desired_capacity"     { type = number }
variable "morning_min_size"             { type = number }
variable "morning_max_size"             { type = number }
variable "morning_recurrence"           { type = string }
variable "evening_desired_capacity"     { type = number }
variable "evening_min_size"             { type = number }
variable "evening_max_size"             { type = number }
variable "evening_recurrence"           { type = string }
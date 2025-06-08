//vpc.tf variables
vpc_name                    = "shiv_vpc"
public_subnet_name          = "shiv_public_subnet"
private_subnet_name         = "shiv_private_subnet"
internet_gateway_name       = "shiv_internet_gateway"

//security_group.tf variables
security_group_name         = "web_security_group"

//environment detail
environment                 = "dev"

//asg.tf variables
ami_name                    = "RHEL-9.5.0_HVM-20241211-x86_64-0-Hourly2-GP3"
virtualization_type         = "hvm"
instance_type_private       = "t2.micro"
instance_name_private       = "web_instance_private"
desired_capacity_private    = 1
min_size_private            = 1
max_size_private            = 1


//asg scheduler variables
# morning scheduler
morning_desired_capacity    = 1
morning_min_size            = 1
morning_max_size            = 1
morning_recurrence          = "0 6 * * *"

#evening scheduler
evening_desired_capacity    = 0
evening_min_size            = 0
evening_max_size            = 0
evening_recurrence          = "0 18 * * *"
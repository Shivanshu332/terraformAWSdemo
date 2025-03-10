//vpc.tf variables
vpc_name                  = "shiv_vpc"
public_subnet_name        = "shiv_public_subnet"
private_subnet_name       = "shiv_private_subnet"
internet_gateway_name     = "shiv_internet_gateway"

//security_group.tf variables
security_group_name = "web_security_group"

//asg.tf variables
ami_name                    = "RHEL-9.5.0_HVM-20241211-x86_64-0-Hourly2-GP3"
virtualization_type         = "hvm"
instance_type_public        = "t2.micro"
instance_type_private       = "t2.micro"
instance_name_public        = "web_instance_public"
instance_name_private       = "web_instance_private"
desired_capacity_public     = 1
max_size_public             = 1
min_size_public             = 1
desired_capacity_private    = 1
min_size_private            = 1
max_size_private            = 1
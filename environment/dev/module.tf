module  vpc  {
  source                      = "../../vpc"
  vpc_name                    = var.vpc_name
  public_subnet_name          = var.public_subnet_name
  private_subnet_name         = var.private_subnet_name
  internet_gateway_name       = var.internet_gateway_name
}

module security_group{
  source                      = "../../security_group"
  security_group_name         = var.security_group_name
  vpc_id                      = module.vpc.vpc_id
}

module asg{
  source                      = "../../asg"
  ami_name                    = var.ami_name
  virtualization_type         = var.virtualization_type
  instance_type_private       = var.instance_type_private
  instance_name_private       = var.instance_name_private    
  desired_capacity_private    = var.desired_capacity_private
  min_size_private            = var.min_size_private       
  max_size_private            = var.max_size_private
  morning_desired_capacity    = var.morning_desired_capacity
  morning_min_size            = var.morning_min_size
  morning_max_size            = var.morning_max_size
  morning_recurrence          = var.morning_recurrence
  evening_desired_capacity    = var.evening_desired_capacity
  evening_min_size            = var.evening_min_size
  evening_max_size            = var.evening_max_size
  evening_recurrence          = var.evening_recurrence
  private_subnet_id           = module.vpc.private_subnet_id
  instance_security_group_id  = module.security_group.instance_security_group_id
}

module lb{
  source                      = "../../loadbalancer"
  public_subnet_id            = module.vpc.public_subnet_id
  lb_security_group_id        = module.security_group.loadbalancer_security_group_id
  vpc_id                      = module.vpc.vpc_id
}
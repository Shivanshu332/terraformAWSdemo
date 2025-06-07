module  vpc  {
  source                      = "../../vpc"
  vpc_name                    = var.vpc_name
  public_subnet_name          = var.public_subnet_name
  private_subnet_name         = var.private_subnet_name
  internet_gateway_name       = var.internet_gateway_name
}

module security_group{
  source = "../../security_group"
  security_group_name         = var.security_group_name
}

module asg{
  source = "../../asg"
  ami_name                    = var.ami_name
  virtualization_type         = var.virtualization_type
  instance_type_public        = var.instance_type_public
  instance_type_private       = var.instance_type_private
  instance_name_public        = var.instance_name_public
  instance_name_private       = var.instance_name_private
  desired_capacity_public     = var.desired_capacity_public
  max_size_public             = var.max_size_public        
  min_size_public             = var.min_size_public        
  desired_capacity_private    = var.desired_capacity_private
  min_size_private            = var.min_size_private       
  max_size_private            = var.max_size_private
}

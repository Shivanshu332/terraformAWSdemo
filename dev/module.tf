module "vpc" {
  source                = "../vpc"
  vpc_name              = var.vpc_name
  public_subnet_name    = var.public_subnet_name
  private_subnet_name   = var.private_subnet_name
  internet_gateway_name = var.internet_gateway_name
  security_group_name   = var.security_group_name
  ami_name              = var.ami_name
  virtualization_type   = var.virtualization_type
  instance_type_public  = var.instance_type_public
  instance_type_private = var.instance_type_private
  instance_name_public  = var.instance_name_public
  instance_name_private = var.instance_name_private
}
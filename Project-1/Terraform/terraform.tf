# Initialize the VPC module
module "vpc_module" {
  source = "./modules/vpc"
}

# Initialize the subnets module
module "subnets_module" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
}

# Initialize the security group module
module "security_group_module" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

# Initialize the load balancer module
module "load_balancer_module" {
  source            = "./modules/load_balancer"
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.subnets.public_subnet_id
  security_group_id = module.security_group.security_group_id
}

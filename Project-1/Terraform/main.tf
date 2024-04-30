provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "my_route53" {
  source = "./modules/route53"

  zone_name   = "mydevopslearning.xyz"
  record_name = "mydevopslearning.xyz"
  tags = {
    Environment = "dev"
  }
}


module "load_balancer" {
  source = "./modules/load_balancer"
  vpc_id = module.vpc.vpc_id
  public_subnet_id  = module.subnets.public_subnet_id  # Make sure to provide the public_subnet_id
  security_group_id = module.security_group.security_group_id
}

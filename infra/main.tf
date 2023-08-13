provider "aws" {
  region  = "ap-southeast-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  sg_id = module.security_group.sg_id
  public_subnet_id = module.vpc.public_subnet_id
  public_key = var.public_key
}

output "public_ip" {
  value = module.ec2.ec2_ip
}
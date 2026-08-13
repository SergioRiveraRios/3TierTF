terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
}

module "network" {
  source = "./modules/network"
  cidr_block = "10.0.0.0/16"
  vpcname = "test"
}

module "security" {
  source = "./modules/security"
  aws-vpc = module.network.vpc-id
}

module "database" {
  source = "./modules/database"
  aws-dbsubnetgroupAZ1 = module.network.aws-dbsubnet-groupAZ1
  aws-dbsubnetgroupAZ2 = module.network.aws-dbsubnet-groupAZ2
  aws-db-security-group = module.security.aws-db-securitygroup
}
module "ec2" {
  source = "./modules/ec2"
  subnet-id = module.network.aws-appsubnet-groupAZ2
  security-group = module.security.aws-app-securitygroup-app
  subnet-id2 = module.network.aws-websubnet-group1
  security-group2 = module.security.aws-web-securitygroup-app
  subnet-id3 = module.network.aws-dbsubnet-groupAZ1
  security-group3 = module.security.aws-app-securitygroup-app
  }

module "s3" {
  source = "./modules/s3"
  bucket_name = "test123-123"
  bucket_region = "us-east-1"
}
module "alb" {
  source = "./modules/ELB"
  aws-vpc = module.network.vpc-id
  ALB_security_group = module.security.aws-loadbalancer-external
  ALB_Subnet1 = module.network.aws-websubnet-group1
  ALB_Subnet2 = module.network.aws-websubnet-group2
  ami_webtier = module.ec2.ami_webtier
  web-tier-security-group = module.security.aws-web-securitygroup-app
}


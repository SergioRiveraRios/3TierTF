terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
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
  aws-securitygroup = module.security.aws-db-securitygroup
}
module "ec2" {
  source = "./modules/ec2"
  subnet-id = module.network.aws-appsubnet-groupAZ2
  security-group = module.security.aws-app-securitygroup-app
  subnet-id2 = module.network.aws-websubnet-group
  security-group2 = module.security.aws-web-securitygroup-app
  subnet-id3 = module.network.aws-dbsubnet-groupAZ1
  security-group3 = module.security.aws-db-securitygroup
}

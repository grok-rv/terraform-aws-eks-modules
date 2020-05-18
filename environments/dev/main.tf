##################################################################
#-------Author: Ramu Reddy --------------------------------
#-------Terraform main config file for provider, backend and eks---
####################################################################

provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = "~/.aws/credentials"
  /*assume_role {
    role_arn              = "arn:aws:iam::var.role-account:role/var.rolename"
  }*/
  profile                 = var.env
  version                 = "~> 2.0"
}


terraform {
  backend "s3" {
      shared_credentials_file = "~/.aws/credentials"
      profile                 = "dev"
      //role_arn                = "arn:aws:iam::var.role-account:role/var.rolename"
      bucket                  = "tl-eks-dev-terraformstate"
      key                     = "dev/backup-state/terraform.tfstate"
      region                  = "us-west-2"
      dynamodb_table          = "tl-eks-dev-terraformstate"
      encrypt                 = true
  }
}



module "storage" {
  source = "../../modules/storage"
}


module "networking" {
  source       = "../../modules/networking"
  cidrblock    = var.cidrblock
  cidr_public  = var.cidr_public
  cidr_private = var.cidr_private
  cluster-name = var.eks-clustername
}


module "securitygroups" {
  source  = "../../modules/securitygroups"
  vpc_id  = module.networking.vpc-id
}


module "eks" {
  source                      = "../../modules/eks"
  cluster-name                = var.eks-clustername
  pub-subnet-ids              = module.networking.public_subnet
  private-subnet-ids          = module.networking.private_subnet
  tf-tl-eks-cluster-sg        = module.securitygroups.tf-tl-eks-clustersecuritygroup-id
  kubernetes-version          = var.eks-kubernetes-version
  nodegroupname               = var.node-group-name
  instance-type               = var.instancetype
  ami-type                    = var.amitype
}

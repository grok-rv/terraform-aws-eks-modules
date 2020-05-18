###############################################################
#------------------Author: Ramu Reddy -----------------
#------------------output terraform resources-----------------
################################################################

output "tl-dev-terraformbucket_name" {
  value       = module.storage.tl-dev-terraformbucket
  description = "The tl eks terraform state bucket"
}

output "tl-dev-terraform-dynamodb_name" {
  value       = module.storage.tl-dev-terraform-dynamodb
  description = "The tl eks terraform dynamodb table for locking state"
}

output "tl-dev-terraform-vpc" {
  value       = module.networking.vpc-id
  description = "The tl eks terraform vpc ID"
}

output "tl-dev-terraform-publicsubnets" {
  value       = module.networking.public_subnet
  description = "tl dev eks public subnets"
}

output "tl-dev-terraform-privatesubnets" {
  value       = module.networking.private_subnet
  description = "tl dev eks private subnets"
}

output "tl-dev-terraform-IGW" {
  value       = module.networking.igw-id
  description = "tl eks terraform Internet gateway"
}

output "tl-dev-terraform-natGW" {
  value       = module.networking.nat-gw
  description = "tl eks terraform nat gateway"
}

output "tl-dev-terraform-eks-clusterSecuritygroup" {
  value = module.securitygroups.tf-tl-eks-clustersecuritygroup
}

output "tl-dev-terraform-eks-workernodesecuritygroup" {
  value = module.securitygroups.tf-tl-eks-workernodesecuritygroup
}

output "tl-dev-terraform-eks-endpoint" {
  value = module.eks.tf-tl-eks-endpoint
}
output "tl-dev-terraform-eks-kubeconfig-cert-authority-data" {
  value = module.eks.tf-tl-eks-kubeconfig-certificate-authority-data
}

#####################################################################
#----------Author: Ramu Reddy -------------------------------
#----------terraform variables file for main config-----------------
########################################################################

variable "aws_region" {
  description = "specify the aws cloud region"
  default     = "us-west-2"
}

variable "env" {
  description = "specify the environment. eg: test or prod"
  default     = "dev"
}
/*
variable "rolename" {
  description = "the role to be used for aws access"
}

variable "role-account" {
  description = "the aws account id"
}
*/
variable "cidrblock" {
  description = "this is the cidr block for vpc to be created. example \"10.123.0.0/16\""
  default     = "10.123.0.0/16"
}

variable "cidr_public" {
  type        = list
  description = "this is the cidr block for public subnet list: example [\"10.123.1.0/24\", \"10.123.2.0/24\"]"
  default     = ["10.123.32.0/20", "10.123.48.0/20"]
}

variable "cidr_private" {
  type        = list
  description = "this is the cidr block for private subnet list: example [\"10.123.3.0/24\", \"10.123.4.0/24\"]"
  default     = ["10.123.0.0/20", "10.123.16.0/20"]
}

variable "eks-clustername" {
  type        = string
  description = "eks cluster name for terraform tl"
  default     = "terraform-tl-eks-test"
}

variable "eks-kubernetes-version" {
  type        = string
  description = "kubernetes version to be used for eks terraform tl cluster"
  default     = "1.15"
}

variable "node-group-name" {
  type        = string
  description = "eks node group name"
  default     = "tf-tl-eks-test-nodegroup"
}

variable "instancetype" {
  type        = list(string)
  description = "eks nodegroup instancetype"
  default     = ["t3.medium"]
}


variable "amitype" {
  type        = string
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to `AL2_x86_64`. Valid values: `AL2_x86_64`, `AL2_x86_64_GPU`. Terraform will only perform drift detection if a configuration value is provided"
  default     = "AL2_x86_64"
}

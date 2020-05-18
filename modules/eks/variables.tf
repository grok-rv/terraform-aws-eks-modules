variable "pub-subnet-ids" {
  type        = list
  description = "public subnet ids used for eks cluster"
}

variable "tf-tl-eks-cluster-sg" {
  type = string
  description = "security group attached for eks cluster"
}

variable "cluster-name" {
  type = string
  description = "eks cluster name for tl"
}

variable "private-subnet-ids" {
  type = list
  description = "private subnet ids for eks managed node group"
}

variable "kubernetes-version" {
  type = string
  description = "desired eks kubernetes version. if you do not specify a version, the latest version is used"
}

variable "nodegroupname" {
  type = string
  description ="the eks node group name"
}

variable "ami-type" {
  type = string
}
variable "instance-type" {
  type = list(string)
}

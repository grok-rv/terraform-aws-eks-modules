##################################################################
#-------------Author: Ramu Reddy --------------------------
#-----------Output for security groups related to eks ---------------
#########################################################################3

output "tf-tl-eks-clustersecuritygroup" {
  value = aws_security_group.tf-tl-eks-master.name
}

output "tf-tl-eks-clustersecuritygroup-id" {
  value = aws_security_group.tf-tl-eks-master.id
}

output "tf-tl-eks-workernodesecuritygroup" {
  value = aws_security_group.tf-tl-eks-node.name
}

output "tf-tl-eks-workernodesecuritygroup-id" {
  value = aws_security_group.tf-tl-eks-node.id
}

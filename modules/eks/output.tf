output "tf-tl-eks-endpoint" {
  value = aws_eks_cluster.tf-tl-eks-master.endpoint
}

output "tf-tl-eks-kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.tf-tl-eks-master.certificate_authority.0.data
}

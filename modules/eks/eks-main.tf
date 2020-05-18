########################################################
#----------Author: ramu reddy ----------------------------
#----------- eks control plan cluster ----------------------
################################################################

####################################################################
# Setup for IAM role needed to setup an EKS cluster
#####################################################################

resource "aws_iam_role" "tf-tl-eks-master" {
  name = "tf-tl-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tf-tl-eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.tf-tl-eks-master.name
}

resource "aws_iam_role_policy_attachment" "tf-tl-eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.tf-tl-eks-master.name
}

###################################################
#--------------set up eks cluster -------------------
######################################################


resource "aws_eks_cluster" "tf-tl-eks-master" {
  name                      = var.cluster-name
  role_arn                  = aws_iam_role.tf-tl-eks-master.arn
  version                   = var.kubernetes-version
  vpc_config {
    security_group_ids      = [var.tf-tl-eks-cluster-sg]
    subnet_ids              = var.pub-subnet-ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.tf-tl-eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.tf-tl-eks-cluster-AmazonEKSServicePolicy,
  ]
}

###############################################################
#-----------_Auhtor: Ramu Reddy--------------------------------
#######################################################################33


########################################################################################
# Setup IAM role & instance profile for worker nodes
##########################################################################################

resource "aws_iam_role" "tf-tl-eks-node" {
  name = "tf-tl-eks-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "tf-tl-eks-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.tf-tl-eks-node.name
}

resource "aws_iam_role_policy_attachment" "tf-tl-eks-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.tf-tl-eks-node.name
}

resource "aws_iam_role_policy_attachment" "tf-tl-eks-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.tf-tl-eks-node.name
}

resource "aws_iam_role_policy_attachment" "tf-tl-eks-node-AmazonEC2FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.tf-tl-eks-node.name
}


resource "aws_iam_instance_profile" "tf-tl-eks-workernode" {
  name = "tf-tl-eks-workernode"
  role = aws_iam_role.tf-tl-eks-node.name
}


#############################################

resource "aws_eks_node_group" "tf-tl-eks-nodegroup" {
  cluster_name    = aws_eks_cluster.tf-tl-eks-master.name
  node_group_name = var.nodegroupname
  node_role_arn   = aws_iam_role.tf-tl-eks-node.arn
  subnet_ids      = var.private-subnet-ids
  ami_type        = var.ami-type
  instance_types  = var.instance-type
  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.tf-tl-eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.tf-tl-eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.tf-tl-eks-node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.tf-tl-eks-node-AmazonEC2FullAccess
  ]

}


resource "aws_security_group_rule" "tf-tl-eks-master-ingress-https" {
  description              = "Allow cluster control to receive communication from the worker Kubelets"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.tf-tl-eks-master.id
  source_security_group_id = aws_security_group.tf-tl-eks-node.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "tf-eks-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.tf-tl-eks-node.id
  source_security_group_id = aws_security_group.tf-tl-eks-master.id
  to_port                  = 443
  type                     = "ingress"
}


###########################################################################################################
resource "aws_security_group_rule" "tf-tl-eks-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.tf-tl-eks-node.id
  source_security_group_id = aws_security_group.tf-tl-eks-node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "tf-tl-eks-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.tf-tl-eks-node.id
  source_security_group_id = aws_security_group.tf-tl-eks-master.id
  to_port                  = 65535
  type                     = "ingress"
}

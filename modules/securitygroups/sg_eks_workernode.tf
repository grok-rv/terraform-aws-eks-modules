##############################################################
#--------------Author: Ramu Reddy : -------------------
#-------------security groups for eks worker node groups------------
#######################################################################

resource "aws_security_group" "tf-tl-eks-node" {
        name        = "tf-tl-eks-nodegroup"
        description = "Security group for all worker nodes in the cluster"
        vpc_id      = var.vpc_id

        egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
}

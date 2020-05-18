###############################################################
#-------------Author: Ramu Reddy: ---------
#----------security group rules for eks master------
##############################################################

resource "aws_security_group" "tf-tl-eks-master" {
    name        = "tf-tl-eks-cluster"
    description = "Cluster communication with worker nodes"
    vpc_id      = var.vpc_id

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

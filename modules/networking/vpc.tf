#---------------create a vpc--------------------------
resource "aws_vpc" "tfs_vpc" {
  cidr_block         = var.cidrblock
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name             = "tf-tl-VPC"
  }
}

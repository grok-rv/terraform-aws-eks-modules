
data "aws_availability_zones" "available_az" {
}

/*
locals {
  tags = {
          "kubernetes.io/cluster/${var.cluster_name}" = "shared"
         }
}
 */
#---------------------public and private subnet resources---------------------
resource "aws_subnet" "tfs_public-subnet" {
  count                   = 2
  cidr_block              = var.cidr_public[count.index]
  map_public_ip_on_launch = true
  vpc_id                  = "${aws_vpc.tfs_vpc.id}"
  availability_zone       = "${data.aws_availability_zones.available_az.names[count.index]}"
  tags = {
    Name             = "tf-tl-publicSubnet-${count.index + 1}"
  }

}

resource "aws_subnet" "tfs_private-subnet" {
  count             = length(aws_subnet.tfs_public-subnet)
  cidr_block        = var.cidr_private[count.index]
  vpc_id            = "${aws_vpc.tfs_vpc.id}"
  availability_zone = "${data.aws_availability_zones.available_az.names[count.index]}"
  tags = {
    Name             = "tf-tl-privateSubnet-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}

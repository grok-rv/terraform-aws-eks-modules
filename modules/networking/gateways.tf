#-----------internet gateway resource in the vpc to talk to internet-------------
resource "aws_internet_gateway" "tfs_ig" {
  vpc_id = "${aws_vpc.tfs_vpc.id}"
  tags = {
    Name             = "tf-tl-IG"
  }
}

#-------allocate an elastic ip------------

resource "aws_eip" "nat-eip" {
  vpc        = true
  depends_on = ["aws_internet_gateway.tfs_ig"]
}

#------------------aws nat gateway for private subnet resources to talk to internet---------------

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat-eip.id}"
  subnet_id     = "${aws_subnet.tfs_public-subnet[1].id}"
  depends_on    = ["aws_internet_gateway.tfs_ig"]
  tags = {
    Name             = "tf-tl-nat-GW"

  }
}

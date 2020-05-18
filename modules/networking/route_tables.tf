#-------------public and private table routes-------------------
resource "aws_route_table" "public-route" {
  vpc_id = "${aws_vpc.tfs_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tfs_ig.id}"
  }
  tags = {
    Name             = "tf-tl-publicRoute"
  }
}


resource "aws_route_table" "private-route" {
  vpc_id = "${aws_vpc.tfs_vpc.id}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
  }
  tags = {
    Name             = "tf-tl-privateRoute"
  }
}

#--------------public and private route tables associations to subnets------------------
resource "aws_route_table_association" "tfs-public-rta" {
  count          = length(aws_subnet.tfs_public-subnet)
  subnet_id      = "${aws_subnet.tfs_public-subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.public-route.id}"
}

resource "aws_route_table_association" "tfs-private-rta" {
  count          = length(aws_subnet.tfs_private-subnet)
  subnet_id      = "${aws_subnet.tfs_private-subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.private-route.id}"
}

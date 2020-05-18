###########################################
#--------Author: Ramu Reddy - rred37--------
#--------output network values---------------
###########################################

output "vpc-id" {
  value       = aws_vpc.tfs_vpc.id
  description = "The VPC id of the cluster"
}

output "public_subnet" {
  value       = aws_subnet.tfs_public-subnet.*.id
  description = "The public subnet details of vpc"
}
output "private_subnet" {
  value       = aws_subnet.tfs_private-subnet.*.id
  description = "The private subnets details of vpc"
}

output "igw-id" {
  value       = aws_internet_gateway.tfs_ig.id
  description = "The internet gateway of cluster"
}

output "nat-gw" {
  value       = aws_nat_gateway.nat-gw.public_ip
  description = "The nat gateway cluster details"
}

###################################################
#-----Author: Ramu Reddy - rred37------
#-----Variable definitions----------
#####################################################

variable "cidrblock" {}
variable "cidr_public" {
  type = list
}
variable "cidr_private" {
  type = list
}

variable "cluster-name" {
  type = string
}
/*
variable "private-subnet-ids" {
  type = list
}


variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `{ BusinessUnit = \"XYZ\" }`"
}
*/

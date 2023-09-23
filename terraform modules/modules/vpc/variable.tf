variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
}

variable "ingrees" {
  type = list(string)
  default = [80,443]
  description = "incoming ports "
}
variable "egress" {
  type = list(string)
  default = [80,443,5432]
  description = "Outgoing ports"
}
variable "common_tags" {
  default = {
    Owner = "aarushi.sharma@cloudeq.com"
    Project = "pandora"
  }
}
variable "tags" {
  default = {
    Product = "vpc"
  }
}
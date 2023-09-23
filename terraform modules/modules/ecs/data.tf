#this block is to refernce id's of already created VPC, SECUIRTY GROUP and subnet ids. use this incase of not creating a new vpc

data "aws_vpc" "stack" {
  filter {
    name = "tag:Name"
    values = ["eks-vpc-stack-VPC"]
  }
}
data "aws_subnets" "public_subnet" {
    filter {
    name   = "eks-vpc-stack-VPC"
    values = [data.aws_vpc.stack.id]
  }
  filter {
    name = "tag=Name"
    value = ["eks-vpc-stack-PublicSubnet01"]
  }
  
}
data "aws_subnet" "public_subnet" {
  for_each = toset(data.aws_subnets.example.ids)
  id       = each.value
}

data "aws_security_group" "selected" {
  id = var.security_group_id
}

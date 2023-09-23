variable "modules" {
  type = map(object({
    vpc_cidr_block        = string
    ecs_cluster_name      = string
    ecs_service_name      = string
    ecs_desired_count     = string
    port                  = string
    aws_lb_target_group   = string
    aws_security_group_lb = string
  }))
}

/*variable "vpc_cidr_block" {
  type = string
}
variable "ecs_cluster_name" {
  type = string
}
variable "ecs_service_name" {
  type = string
}
variable "ecs_desired_count" {
  type = string
}

variable "port" {
  type = string
}
# variable "aws_lb" {
#   type = string
# }
variable "aws_lb_target_group" {
  type = string
}
variable "aws_security_group_lb" {
  type = string
}*/

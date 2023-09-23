/*variable "ecs" {
  type = map(object({
    ecs_cluster_name = string
    ecs_task_definition = string
    ecs_service_name = string
    ecs_desired_count = string
    aws_security_group_ecs = string 
    port = string
    aws_lb_target_group = string
    vpc_id = string 
    aws_security_group_lb_name = string
  }))
}*/
variable "subnet_id" {
  description = "List of subnet IDs for the ECS service"
  #type        = string
}
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster."
}

variable "ecs_task_definition" {
  description = "JSON representation of the ECS task definition."
}

variable "ecs_service_name" {
  description = "The name of the ECS service."
}

variable "ecs_desired_count" {
  description = "The desired number of tasks to run."
  default     = 1
}


variable "aws_security_group_ecs" {
  description = "List of security group IDs for the ECS service"
  type        = string
}

# variable "aws_lb" {
#   type = string
# }
variable "port" {
  type = string
}
variable "aws_lb_target_group" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "public_subnet" {
}

variable "aws_security_group_lb_name" {
  type = string
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
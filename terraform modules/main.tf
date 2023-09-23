module "vpc" {
  for_each       = var.modules
  source         = "./modules/vpc"
  vpc_cidr_block = each.value["vpc_cidr_block"]

}


module "ecs" {
  for_each               = var.modules
  source                 = "./modules/ecs"
  ecs_cluster_name       = each.value["ecs_cluster_name"]
  ecs_service_name       = each.value["ecs_service_name"]
  ecs_desired_count      = each.value["ecs_desired_count"]
  aws_security_group_ecs = module.vpc[each.key].ecs_security_group_id
  # aws_lb              = module.ecs.aws_lb.ecs_alb.id
  port                       = each.value["port"]
  subnet_id                  = module.vpc[each.key].public_subnet_ids
  aws_lb_target_group        = each.value["aws_lb_target_group"]
  vpc_id                     = module.vpc[each.key].vpc_id
  aws_security_group_lb_name = each.value["aws_security_group_lb"]
  ecs_task_definition        = <<TASK_DEFINITION
[
  {
    "name": "nginx",
    "image": "nginx:1.23.4",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "essential": true
  }
]
TASK_DEFINITION
}
resource "aws_instance" "instance" {
  provider = aws.aarushi
  ami           = "ami-08a52ddb321b32a8c"
  instance_type = "t2.micro"
}

# Define the Load Balancer

# use the concept of for_each to access the variable
# read about meta-arguments

#merge function
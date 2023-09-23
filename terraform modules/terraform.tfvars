# VPC Module variables

modules = {
  "module1" = {
    vpc_cidr_block        = "10.0.0.0/16"
    ecs_cluster_name      = "my-ecs-cluster"
    ecs_service_name      = "my-ecs-service"
    ecs_desired_count     = "1"
    port                  = "80"
    aws_lb_target_group   = "my-lb-target-group"
    aws_security_group_lb = "my-lb-security-group"
  },
  "module2" = {
    vpc_cidr_block        = "10.1.0.0/16"
    ecs_cluster_name      = "another-ecs-cluster"
    ecs_service_name      = "another-ecs-service"
    ecs_desired_count     = "3"
    port                  = "8080"
    aws_lb_target_group   = "another-lb-target-group"
    aws_security_group_lb = "another-lb-security-group"
  }
}

vpc_cidr_block = "10.0.0.0/16"

# ECS Module variables
/*ecs_cluster_name    = "MyECSCluster"
ecs_service_name    = "MyECSService"
ecs_desired_count   = 2
port                = 80
# aws_lb              = "cluster-lb"
aws_lb_target_group = "lb-Tg"
aws_security_group_lb      = "lb-SG"*/

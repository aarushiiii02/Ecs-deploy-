resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name

  tags = {
   Owner = local.merged_map
  }
}
#use the concept of merge for tagging
# terraform function

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ECSExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.ecs_service_name
  network_mode             = var.vpc_id
  requires_compatibilities = ["FARGATE"]


  container_definitions = jsonencode([
    {
      name  = "my-container",
      image = "nginx:latest",
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80
        }
      ]
    }
  ])
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn # Assign the same IAM role to both execution_role_arn and task_role_arn

}

#nested block


# Security group for the load balancer 
resource "aws_security_group" "ecs_alb_sg" {
  name_prefix = var.aws_security_group_lb_name
}

# the load balncer 
resource "aws_lb" "ecs_alb" {
  name               = "ecs-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_alb_sg.id]
  subnets            = var.subnet_id
  tags = {
   Name = local.merged_map
  }
}

# add listeners to the load balancer 
resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }
}
resource "aws_lb_target_group" "ecs_target_group" {
  name     = var.aws_lb_target_group
  port     = var.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

}


resource "aws_ecs_service" "main" {
  name            = var.vpc_id
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.ecs_desired_count

  launch_type = "FARGATE"
  network_configuration {
    security_groups = [var.aws_security_group_ecs]
    subnets         = var.subnet_id
  }
  load_balancer {

    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    container_name   = "my-container" # Replace with the name of your container in the task definition
    container_port   = var.port       # Replace with the port your container is listening on}
  }
  depends_on = [aws_ecs_task_definition.main]

}

# data "terraform_remote_state" "vpc" {
#   backend = "local"  # Change this to your backend configuration for Module 1

#   config = {
#     path = "./modules/vpc/terraform.tfstate"  # Replace with the actual path to the state file of Module 1
#   }
# }



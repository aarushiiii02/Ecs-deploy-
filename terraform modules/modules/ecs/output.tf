# output "ecs_service_url" {
#   value = aws_ecs_service.main.
# }

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.main.arn
}
output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
  }

output "end_point" {
  value = aws_lb_listener.ecs_alb_listener
}
output "vpc_id"{
    value = data.aws_vpc.stack.id
}
output "subnet_id" {
  value = data.aws_subnet.public_subnet.id
}
output "cluster_name" {
    value = aws_ecs_cluster.dock.name
}

output "service_name" {
  value = aws_ecs_service.dock.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.dock.arn
}

output "task_security_group_id" {
    value = aws_security_group.task.id
}
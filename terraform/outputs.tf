output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "frontend_public_ip" {
  value = aws_instance.frontend_server.public_ip
}

output "backend_private_ip" {
  value = aws_instance.backend_server.private_ip
}

output "frontend_instance_id" {
  value = aws_instance.frontend_server.instance_id
}

output "backend_instance_id" {
  value = aws_instance.backend_server.instance_id
}



      output github_actions_role {
        value = aws_iam_role.github_actions_role.arn
      }

      output db_name {
        value = aws_db_instance.postgres.db_name
      }

      output db_endpoint {
        value = aws_db_instance.postgres.endpoint
      }

      output db_port {
        value = aws_db_instance.postgres.port
      }

      output db_username {
        value = aws_db_instance.postgres.username
      }

      output db_password {
        value = aws_db_instance.postgres.password
        sensitive = true
      }

      output frontend_public_ip {
        value = data.aws_instances.frontend_asg_instances.public_ips
      }

      output frontend_private_ip {
        value = data.aws_instances.frontend_asg_instances.private_ips
      }

      output  backend_private_ip {
        value = data.aws_instances.backend_asg_instances.private_ips
      }

      output frontend_instance_id {
        value = data.aws_instances.frontend_asg_instances.ids
      }

      output backend_instance_id {
        value = data.aws_instances.backend_asg_instances.ids
      }

      output "backend_tg_arn" {
      value = aws_lb_target_group.backend_tg.arn 
      }

      output "frontend_tg_arn" {
      value = aws_lb_target_group.frontend_tg.arn
      }







/*========================
output "backend_private_ips" {
  value = data.aws_instances.backend_asg_instances.private_ips
}

output "backend_instance_ids" {
  value = data.aws_instances.backend_asg_instances.ids
}
=========================*/


      /*output frontend_public_ip {
        value = aws_instance.frontend_server.public_ip
      }

      output frontend_private_ip {
        value = aws_instance.frontend_server.private_ip
      }

      output  backend_private_ip {
        value = aws_instance.backend_server.private_ip
      }

      output frontend_instance_id {
        value = aws_instance.frontend_server.id
      }

      output backend_instance_id {
        value = aws_instance.backend_server.id
      }*/


 
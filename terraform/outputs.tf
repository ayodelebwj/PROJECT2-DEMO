
      output frontend_pub_ip {
        value = aws_instance.frontend_server.public_ip
      }

      output  backend_pri_ip {
        value = aws_instance.backend_server.private_ip
      }

      output frontend_instance_id {
        value = aws_instance.frontend_server.id
      }

      output backend_instance_id {
        value = aws_instance.backend_server.id
      }

      output role_arn {
        value = aws_iam_role.github_actions_role.arn
      }
      
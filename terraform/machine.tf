//Step 4 — Attach to EC2..
resource "aws_instance" "backend_server" {
  ami                    = var.backend_server_ami
  instance_type          = var.backend_server_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = data.aws_subnet.private_subnet.id
  key_name               = var.backend_server_key_name

    vpc_security_group_ids = [
    aws_security_group.backend_sg.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              # Update system packages
              sudo apt update -y
              sudo apt install -y snapd
              sudo snap install core
              sudo snap refresh core
              sudo snap install amazon-ssm-agent --classic
              sudo snap start amazon-ssm-agent
              sudo snap enable amazon-ssm-agent
              EOF


  tags = {
    Name = var.backend_server_tags_Name
    Role = var.backend_server_tags_Role
  }
}

resource "aws_instance" "frontend_server" {
  ami                    = var.frontend_server_ami
  instance_type          = var.frontend_server_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = data.aws_subnet.public_subnet.id
  key_name               = var.frontend_server_key_name

    vpc_security_group_ids = [
    aws_security_group.frontend_sg.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              # Update system packages
              sudo apt update -y
              sudo apt install -y snapd
              sudo snap install core
              sudo snap refresh core
              sudo snap install amazon-ssm-agent --classic
              sudo snap start amazon-ssm-agent
              sudo snap enable amazon-ssm-agent
              EOF


  tags = {
    Name = var.frontend_server_tags_Name
    Role = var.frontend_server_tags_Role
  }
}



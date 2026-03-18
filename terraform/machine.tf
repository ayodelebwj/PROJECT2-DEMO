//Step 4 — Attach to EC2..
/*resource "aws_instance" "backend_server" {
  ami                    = data.aws_ami.backend_ami.id
  instance_type          = var.backend_server_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = data.aws_subnet.private_subnet.id
  key_name               = var.backend_server_key_name

    vpc_security_group_ids = [
    aws_security_group.backend_sg.id
  ]

  tags = {
    Name = var.backend_server_tags_Name
    Role = var.backend_server_tags_Role
  }
}

resource "aws_instance" "frontend_server" {
  ami                    = data.aws_ami.frontend_ami.id
  instance_type          = var.frontend_server_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = data.aws_subnet.public_subnet.id
  key_name               = var.frontend_server_key_name

    vpc_security_group_ids = [
    aws_security_group.frontend_sg.id
  ]

  tags = {
    Name = var.frontend_server_tags_Name
    Role = var.frontend_server_tags_Role
  }
}*/



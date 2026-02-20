//Step 4 — Attach to EC2..
resource "aws_instance" "backend_server" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = data.aws_subnet.private_subnet.id
  key_name               = "myjob744-kp"

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
    Name = "backend-instance"
    Role = "backend"
  }
}

resource "aws_instance" "frontend_server" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = data.aws_subnet.public_subnet.id
  key_name               = "myjob744-kp"

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
    Name = "frontend-instance"
    Role = "frontend"
  }
}

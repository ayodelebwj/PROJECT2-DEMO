resource "aws_launch_template" "frontend_lt" {
image_id               = data.aws_ami.frontend_ami.id
instance_type          = var.frontend_server_instance_type
key_name               = var.frontend_server_key_name


  iam_instance_profile{
    name = aws_iam_instance_profile.ssm_profile.name
  }   

    vpc_security_group_ids = [
    aws_security_group.frontend_ec2_sg.id
  ]

  tags = {
    Name = var.frontend_server_tags_Name
    Role = var.frontend_server_tags_Role
    }
  }


resource "aws_launch_template" "backend_lt" {
  image_id                    = data.aws_ami.backend_ami.id
  instance_type               = var.backend_server_instance_type
  key_name               = var.backend_server_key_name

  iam_instance_profile {
  name = aws_iam_instance_profile.ssm_profile.name
  }  

    vpc_security_group_ids = [
    aws_security_group.backend_ec2_sg.id
  ]

  tags = {
    Name = var.backend_server_tags_Name
    Role = var.backend_server_tags_Role
  }
}

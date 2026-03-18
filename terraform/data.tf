data "aws_instances" "backend_asg_instances" {
  filter {
    name   = "tag:Role"
    values = ["backend"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

data "aws_instances" "frontend_asg_instances" {
  filter {
    name   = "tag:Role"
    values = ["frontend"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}
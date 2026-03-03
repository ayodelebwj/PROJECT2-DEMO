data "aws_ami" "frontend_ami" {
  most_recent = true

  owners = ["self"]

  filter {
    name   = "tag:Project"
    values = ["frontend"]
  }
}

data "aws_ami" "backend_ami" {
  most_recent = true

  owners = ["self"]

  filter {
    name   = "tag:Project"
    values = ["backend"]
  }
}

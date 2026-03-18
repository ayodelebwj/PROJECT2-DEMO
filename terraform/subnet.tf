/*data "aws_subnet" "private_subnet" {
  id = var.private_subnet_id
}

data "aws_subnet" "public_subnet" {
  id = var.public_subnet_id
}*/





data "aws_subnet" "public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet"]
  }
}

data "aws_subnet" "public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["pub-subnet-2"]
  }
}

data "aws_subnet" "private_subnet" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet"]
  }
}

data "aws_subnet" "private_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["pri-subnet-2"]
  }
}
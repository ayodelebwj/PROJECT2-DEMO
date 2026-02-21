resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  description = "Security group for FRONTEND EC2 instances"
  vpc_id      = data.aws_vpc.myvpc.id

  # Allow HTTP from ALB only
  ingress {
    description     = "Allow HTTP from INTERNET"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   # Allow SSH from ALB only
  ingress {
    description     = "Allow SSH from INTERNET"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS from ALB only.
  ingress {
    description     = "Allow HTTPS from INTERNET"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic (required for SSM if no VPC endpoint)
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "frontend-sg"
  }
}

resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Security group for backend EC2 instances"
  vpc_id      = data.aws_vpc.myvpc.id

  # Allow HTTP from frontend only
  ingress {
    description     = "Allow HTTP from FRONTEND"
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  # Allow all outbound traffic (required for SSM if no VPC endpoint)
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "backend-sg"
  }
}


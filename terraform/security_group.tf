resource "aws_security_group" "frontend_sg" {
  name        = var.frontend_sg_name
  description = "Security group for FRONTEND EC2 instances"
  vpc_id      = data.aws_vpc.myvpc.id

  # Allow HTTP from ALB only..
  ingress {
    description     = "Allow HTTP from INTERNET"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Allow Prometheus metrics from INTERNET"
    from_port       = 9090
    to_port         = 9090
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description     = "Allow Node Exporter metrics from INTERNET"
    from_port       = 9100
    to_port         = 9100
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description     = "Allow Grafana metrics from INTERNET"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   # Allow SSH from ALB only..
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
    Name        = var.frontend_sg_tag_name
  }
}

resource "aws_security_group" "backend_sg" {
  name        = var.backend_sg_name
  description = "Security group for backend EC2 instances"
  vpc_id      = data.aws_vpc.myvpc.id

  # Allow HTTP from frontend only
  ingress {
    description     = "Allow HTTP from FRONTEND"
    from_port       = var.backend_sg_from_port
    to_port         = var.backend_sg_to_port
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  ingress {
    description     = "Allow Node Exporter metrics from Prometheus"
    from_port       = 9100
    to_port         = 9100
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
    Name        = var.backend_sg_tag_Name
  }
}

# Database Security Group
resource "aws_security_group" "db_sg" {
  name        = "project-db-sg"
  description = "Allow backend to access database"
  vpc_id      = data.aws_vpc.myvpc.id

  # Allow PostgreSQL from backend SG only
  ingress {
    description     = "Postgres from backend"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  # Allow outbound traffic (required)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project-db-sg"
  }
}

# Security group for VPC endpoints
resource "aws_security_group" "ssm_endpoint_sg" {
  name        = "ssm-endpoint-sg"
  description = "Allow private instances to access SSM endpoints"
  vpc_id      = data.aws_vpc.myvpc.id

  # Allow instances in the private subnet to reach the endpoint
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    #cidr_blocks = [var.private_subnet_cidr_1, var.private_subnet_cidr_2]  # your private subnet CIDR
    #security_groups = [aws_security_group.backend_sg.id, aws_security_group.frontend_sg.id]
    #cidr_blocks = ["10.0.0.0/16"]
    cidr_blocks = ["10.0.2.0/24", "10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



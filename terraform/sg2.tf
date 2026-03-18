resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP and HTTPS to ALB"
  vpc_id      = data.aws_vpc.myvpc.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from internet"

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-security-group"
  }
}

resource "aws_security_group" "frontend_ec2_sg" {
  name        = "frontend-ec2-sg"
  description = "Allow traffic from ALB to frontend EC2"
  vpc_id      = data.aws_vpc.myvpc.id

  ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

    ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    description = "Allow SSH from admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "frontend-security-group"
  }
}

resource "aws_security_group" "backend_alb_sg" {
  name        = "backend-alb-security-group"
  description = "Allow FRONTEND TRAFFIC to ALB"
  vpc_id      = data.aws_vpc.myvpc.id

  ingress {
    description = "HTTP from FRONTEND"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    security_groups = [aws_security_group.frontend_ec2_sg.id]
  }

  egress {
    description = "Allow outbound traffic"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "backend-alb-security-group"
  }
}

resource "aws_security_group" "backend_ec2_sg" {
  name        = "backend-ec2-sg"
  description = "Allow traffic from ALB to backend EC2"
  vpc_id      = data.aws_vpc.myvpc.id

  ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_alb_sg.id]
  }

    ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_ec2_sg.id]
  }

    ingress {
    description     = "Allow Node Exporter metrics from Prometheus"
    from_port       = 9100
    to_port         = 9100
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "backend-security-group"
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
    security_groups = [aws_security_group.backend_ec2_sg.id]
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
